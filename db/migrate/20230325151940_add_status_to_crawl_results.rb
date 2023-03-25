class AddStatusToCrawlResults < ActiveRecord::Migration[7.0]
  def change
    add_column :crawl_results, :status, :integer, null: false, default: 0, after: :keyword
  end
end
