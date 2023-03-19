module Scraper
  class CreateCrawlJobService < ApplicationService
    BATCH_SIZE = 20

    def initialize(csv_file, user_id)
      @csv_file = csv_file
      @user_id = user_id
      @keywords = []
    end

    def call
      CSV.foreach(csv_file) { |row| keywords << row.first }

      batch = Sidekiq::Batch.new
      batch.on(:success, CrawlJobCallbackService)
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
