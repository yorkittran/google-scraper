require 'csv'

module Scraper
  class SearchService < ApplicationService
    GOOGLE_SEARCH_URL = 'https://www.google.com.vn/search?gl=us&q='.freeze
    IMPORT_CRAWL_RESULT_COLUMNS = %i[user_id keyword total_results search_time total_links total_ads source].freeze

    def initialize(csv_file, current_user_id)
      @csv_file = csv_file
      @current_user_id = current_user_id
      @crawl_results = []
    end

    def call
      total_proxies = Settings.proxy.proxies.count
      CSV.foreach(csv_file).with_index do |keyword, index|
        browser = Watir::Browser.new(:edge, headless: true, proxy: proxy(index % total_proxies))
        browser.goto("#{GOOGLE_SEARCH_URL}#{keyword.first}")
        crawl_results << crawl_data(keyword.first, browser.html)
        browser.quit
      end

      CrawlResult.import(IMPORT_CRAWL_RESULT_COLUMNS, crawl_results)
    end

  private

    attr_reader :csv_file, :current_user_id, :crawl_results

    def crawl_data(keyword, html)
      doc = Nokogiri::HTML.parse(html)
      {
        user_id: current_user_id,
        keyword:,
        total_results: doc.xpath("//div[@id='result-stats']/text()").text.delete('^0-9').to_i,
        search_time: doc.xpath("//div[@id='result-stats']/nobr/text()").text.delete('^0-9.').to_f,
        total_links: doc.xpath('//a/@href').count,
        total_ads: doc.xpath("//div[@aria-label='Ads']/div").count,
        source: html
      }
    end

    def proxy(index)
      {
        http: "#{Settings.proxy.username}:#{Settings.proxy.password}@#{Settings.proxy.proxies[index]}",
        ssl: "#{Settings.proxy.username}:#{Settings.proxy.password}@#{Settings.proxy.proxies[index]}"
      }
    end
  end
end
