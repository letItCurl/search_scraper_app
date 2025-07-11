class Keyword < ApplicationRecord
  belongs_to :user

  enum :status, [ :pending, :processing, :completed, :failed ]

  validates :name, presence: true

  def bing_url
    query = URI.encode_www_form_component(self.name)
    url = "https://www.bing.com/search?q=#{query}"
  end
end

# == Schema Information
#
# Table name: keywords
#
#  id          :uuid             not null, primary key
#  name        :string
#  total_ads   :integer
#  total_links :integer
#  html_cache  :text
#  user_id     :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_keywords_on_user_id  (user_id)
#