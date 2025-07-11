class KeywordsUpload::ProcessingJob < ApplicationJob
  queue_as :default

  def perform(keywords_upload_id:)
    @keywords_upload = KeywordsUpload.find(keywords_upload_id)
    @keywords_upload.processing!

    @keywords_upload.csv_file.open do |file|
      csv = CSV.read(file.path, headers: true)

      required_headers = ["keyword"]
      missing_headers = required_headers - csv.headers.compact.map(&:strip)

      if missing_headers.any?
        message = "Missing required headers: #{missing_headers.join(', ')}"
        @keywords_upload.update(failure_reason: message, status: :failed)
        raise message
      end

      keywords = csv.map { |row| row["keyword"] }.compact.uniq

      keywords.each do |keyword|
        Keyword::ProcessingJob.perform_later(keyword: keyword, user_id: @keywords_upload.user_id)
      end
    end

    @keywords_upload.completed!
  rescue => e
    @keywords_upload.failed!
    Rails.logger.error("[KeywordsUploadJob] Failed for ID=#{keywords_upload_id}: #{e.message}")
    raise e
  end
end
