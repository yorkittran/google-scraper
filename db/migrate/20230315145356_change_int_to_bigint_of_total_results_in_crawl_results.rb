class ChangeIntToBigintOfTotalResultsInCrawlResults < ActiveRecord::Migration[7.0]
  def change
    change_column :crawl_results, :total_results, :bigint
  end
end
