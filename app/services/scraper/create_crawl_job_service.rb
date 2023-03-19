require 'csv'

module Scraper
  class CreateCrawlJobService < ApplicationService
    BATCH_SIZE = 10

    attr_reader :error

    def initialize(csv_file, user_id)
      @csv_file = csv_file
      @user_id = user_id
      @error = nil
      @keywords = []
    end

    def call
      CSV.foreach(csv_file) { |row| keywords << row.first }
      return @error = "Please upload fewer than #{CrawlResult::CSV_LIMIT_LINES} keywords!" if keywords.count > CrawlResult::CSV_LIMIT_LINES

      batch = Sidekiq::Batch.new
      batch.jobs do
        keywords.each_slice(BATCH_SIZE) do |batch_keywords|
          CrawlGoogleSearchWorker.perform_async(batch_keywords, user_id, batch.bid)
        end
      end
    end

  private

    attr_reader :csv_file, :user_id, :keywords
  end
end
