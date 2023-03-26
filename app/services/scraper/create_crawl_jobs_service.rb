require 'csv'

module Scraper
  class CreateCrawlJobsService < ApplicationService
    BATCH_SIZE = 20

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

      total_proxies = Settings.proxy.proxies.count
      keywords.each.with_index do |keyword, index|
        ::CrawlGoogleSearchJob.perform_async(keyword, user_id, index % total_proxies)
      end
    end

  private

    attr_reader :csv_file, :user_id, :keywords
  end
end
