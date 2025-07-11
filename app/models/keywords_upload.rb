class KeywordsUpload < ApplicationRecord
  belongs_to :user

  enum :status, [ :pending, :processing, :completed, :failed ]

  has_one_attached :csv_file
  after_create :start_processing_job

  validate :csv_file_presence
  validate :csv_file_format

  private

  def csv_file_presence
    errors.add(:csv_file, "must be attached") unless csv_file.attached?
  end

  def csv_file_format
    return unless csv_file.attached?

    if !csv_file.filename.to_s.ends_with?(".csv")
      errors.add(:csv_file, "must be a CSV file")
    end
  end

  def start_processing_job
    KeywordsUpload::ProcessingJob.perform_later(keywords_upload_id: self.id)
  end
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
