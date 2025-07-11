class KeywordsUpload < ApplicationRecord
  belongs_to :user

  enum :status, [ :pending, :processing, :completed, :failed ]
end

# == Schema Information
#
# Table name: keywords_uploads
#
#  id         :uuid             not null, primary key
#  status     :integer
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_keywords_uploads_on_user_id  (user_id)
#
