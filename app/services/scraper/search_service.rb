module Scraper
  class SearchService < ApplicationService
    GOOGLE_SEARCH_URL = 'https://www.google.com.vn/search?q='.freeze
    IMPORT_CRAWL_RESULT_COLUMNS = %i[user_id keyword total_results search_time total_links total_ads source].freeze

    def initialize(csv_file, current_user_id)
      @csv_file = csv_file
      @current_user_id = current_user_id
      @browser = Watir::Browser.new(:chrome, headless: true)
      @crawl_results = []
    end

    def call
      CSV.foreach(csv_file) do |keyword|
        browser.goto("#{GOOGLE_SEARCH_URL}#{keyword.first}")
        crawl(keyword.first)
      end
      browser.close

      CrawlResult.import(IMPORT_CRAWL_RESULT_COLUMNS, crawl_results)
    end

  private

    attr_reader :csv_file, :current_user_id, :browser, :crawl_results

    def crawl(keyword) # rubocop:disable Metrics/AbcSize
      data = {}
      doc = Nokogiri::HTML.parse(browser.html)
      stats = browser.element(id: 'result-stats').text.split
      data[:user_id] = current_user_id
      data[:keyword] = keyword
      data[:total_results] = stats[1].delete('.').to_i
      data[:search_time] = stats[4][1..].tr(',', '.').to_f
      data[:total_links] = doc.xpath('//a/@href').count
      data[:total_ads] = doc.xpath("//div[@aria-label='Quảng cáo']/div").count
      data[:source] = browser.html
      crawl_results << data
    end
  end
end
