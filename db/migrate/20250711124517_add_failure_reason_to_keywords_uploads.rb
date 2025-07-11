class AddFailureReasonToKeywordsUploads < ActiveRecord::Migration[8.0]
  def change
    add_column :keywords_uploads, :failure_reason, :string
  end
end
