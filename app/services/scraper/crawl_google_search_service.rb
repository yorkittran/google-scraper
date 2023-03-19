module Scraper
  class CrawlGoogleSearchService < ApplicationService
    GOOGLE_SEARCH_URL = 'https://www.google.com.vn/search?gl=us&q='.freeze
    IMPORT_CRAWL_RESULT_COLUMNS = %i[user_id keyword total_results search_time total_links total_ads source].freeze

    def initialize(keywords, user_id, batch_id)
      @keywords = keywords
      @user_id = user_id
      @batch_id = batch_id
      @crawl_results = []
      @failed_keywords = []
    end

    def call
      total_proxies = Settings.proxy.proxies.count
      keywords.each.with_index do |keyword, index|
        browser = Watir::Browser.new(:chrome, headless: true, proxy: proxy(index % total_proxies))
        browser.goto("#{GOOGLE_SEARCH_URL}#{keyword}")
        unless browser.element(id: 'result-stats').present?
          failed_keywords << keyword
          next
        end
        puts "#{index} - #{keyword}"
        crawl_results << crawl_data(keyword, browser.html)
        browser.quit
        failed_keywords << keyword
      end

      CrawlResult.import(IMPORT_CRAWL_RESULT_COLUMNS, crawl_results)
    end

  private

    attr_reader :keywords, :user_id, :batch_id, :crawl_results, :failed_keywords

    def crawl_data(keyword, html)
      doc = Nokogiri::HTML.parse(html)
      {
        user_id: user_id,
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
