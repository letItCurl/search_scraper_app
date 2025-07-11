class CreateKeywordsUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :keywords_uploads, id: :uuid do |t|
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
