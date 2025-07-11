require 'ferrum'

class Keyword::ProcessingJob < ApplicationJob
  queue_as :default

  # Retry only on this specific error, up to 3 times with exponential backoff
  retry_on Ferrum::NodeNotFoundError, wait: :exponentially_longer, attempts: 3

  def perform(user_id:, keyword:)
    user = User.find(user_id)
    keyword_record = user.keywords.create!(name: keyword, status: :processing)

    browser = Ferrum::Browser.new(
      headless: true,
      timeout: 30,
      browser_options: {
        'no-sandbox': nil,
        'disable-gpu': nil
      }
    )

    query = URI.encode_www_form_component(keyword)
    url = "https://www.bing.com/search?q=#{query}"

    begin
      browser.go_to(url)

      browser.network.wait_for_idle

      html_cache = browser.body

      # Count all links
      total_links = 0
      total_links += browser.css('a').count

      # Try to count ads – rough estimate based on Bing ad containers
      total_ads = 0
      total_ads += browser.css('div > span.b_adSlug.b_opttxt.b_divdef').count
      total_ads += browser.css('div.mma_acf_label_container > span').count


      keyword_record.update!(
        total_links: total_links,
        total_ads: total_ads,
        html_cache: html_cache,
        status: :completed
      )
    rescue => e
      if Rails.env.development?
        browser.screenshot(path: "tmp/debug_#{keyword.parameterize}.png")
      end

      keyword_record.update(status: :failed, failure_reason: e.message)
      Rails.logger.error "Failed to process keyword: #{keyword} - #{e.class}: #{e.message}"
      raise e
    ensure
      browser.quit
    end
  end
end
