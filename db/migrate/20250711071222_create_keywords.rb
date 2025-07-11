class CreateKeywords < ActiveRecord::Migration[8.0]
  def change
    create_table :keywords, id: :uuid do |t|
      t.string :name
      t.integer :total_ads
      t.integer :total_links
      t.text :html_cache
      t.integer :status, default: 0
      t.string :failure_reason
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
