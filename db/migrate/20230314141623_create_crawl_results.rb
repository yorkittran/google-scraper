class CreateCrawlResults < ActiveRecord::Migration[7.0]
  def change
    create_table :crawl_results do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_results, null: false, default: 0
      t.float :search_time, null: false, default: 0
      t.integer :total_ads, null: false, default: 0
      t.integer :total_links, null: false, default: 0
      t.text :source

      t.timestamps
    end
  end
end
