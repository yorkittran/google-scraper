class AddKeywordToCrawlResults < ActiveRecord::Migration[7.0]
  def change
    add_column :crawl_results, :keyword, :string, null: false, after: :user_id
  end
end
