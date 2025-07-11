require 'ferrum'
require 'async'

class Keyword::ProcessingJob < ApplicationJob
  SAMPLE_SIZE = 10
  queue_as :default

  def perform(keyword_id: nil, user_id: nil, keyword: nil)
    if keyword_id.nil?
      user = User.find(user_id)
      @keyword = user.keywords.create!(name: keyword, status: :processing)
    else
      @keyword = Keyword.find(keyword_id)
    end

    url = @keyword.bing_url

    total_links_samples = []
    total_ads_samples = []
    html_snapshots = []

    Async do |task|
      tasks = SAMPLE_SIZE.times.map do
        task.async do
          browser = Ferrum::Browser.new(
            headless: true,
            timeout: 30,
            browser_options: {
              'no-sandbox': nil,
              'disable-gpu': nil
            }
          )

          begin
            browser.go_to(url)
            browser.network.wait_for_idle

            html_snapshots << browser.body

            matching_links = browser.css('a').map do |node|
              href = node.attribute('href')
              href if href&.start_with?("https://www.bing.com/aclick?")
            end.compact

            total_links = matching_links.size

            total_ads = browser.css('span.b_adSlug.b_opttxt.b_divdef').count +
                        browser.css('div.mma_acf_label_container > span').count

            total_links_samples << total_links
            total_ads_samples << total_ads
          rescue => e
            Rails.logger.error "Async scrape failed: #{e.message}"
          ensure
            browser.quit
          end
        end
      end

      tasks.each(&:wait) # Wait for all async runs to complete
    end

    if total_links_samples.empty? || total_ads_samples.empty?
      @keyword.update!(status: :failed, failure_reason: "All async attempts failed.")
      return
    end

    average_links = (total_links_samples.sum.to_f / total_links_samples.size).round
    average_ads = (total_ads_samples.sum.to_f / total_ads_samples.size).round
    html_cache = html_snapshots.compact.first

    @keyword.update!(
      total_links: average_links,
      total_ads: average_ads,
      html_cache: html_cache,
      status: :completed
    )
  end
end
