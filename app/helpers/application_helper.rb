require 'digest'

module ApplicationHelper
  # Returns the Gravatar URL for the given email
  def gravatar_url(email, size: 80)
    gravatar_id = Digest::MD5.hexdigest(email.strip.downcase)
    "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end
end
