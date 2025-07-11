class KeywordsUpload::ProcessingJob < ApplicationJob
  queue_as :default

  def perform(keywords_upload_id:)
    @keywords_upload = KeywordsUpload.find(keywords_upload_id)
    @keywords_upload.processing!

    @keywords_upload.csv_file.open do |file|
      keywords = []
      CSV.foreach(file.path, headers: true) do |row|
        keywords << row["keyword"]
      end

      keywords.uniq.each do |keyword|
        Keyword::ProcessingJob.perform_later(keyword: keyword, user_id: @keywords_upload.user_id)
      end
    end

    @keywords_upload.completed!
  end
end
