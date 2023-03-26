module Scraper
  class CrawlGoogleSearchService < ApplicationService
    GOOGLE_SEARCH_URL = 'https://www.google.com.vn/search?gl=us&q='.freeze
    IMPORT_CRAWL_RESULT_COLUMNS = %i[user_id keyword total_results search_time total_links total_ads source].freeze

    def initialize(keyword, user_id, proxy_index)
      @keyword = keyword
      @user_id = user_id
      @proxy_index = proxy_index
    end

    def call
      @crawl_result = CrawlResult.create(user_id: user_id, keyword: keyword, status: :pending)
      crawl_data
      create_notification if crawl_result.failed?
    end

  private

    attr_reader :keyword, :user_id, :proxy_index, :crawl_result

    def crawl_data
      browser = Watir::Browser.new(:chrome, headless: true, proxy: proxy(proxy_index))
      browser.goto("#{GOOGLE_SEARCH_URL}#{keyword}")

      return crawl_result.update!(status: :failed) unless browser.element(id: 'result-stats').present? # rubocop:disable Rails/Blank

      doc = Nokogiri::HTML.parse(browser.html)
      crawl_result.update!(
        total_results: doc.xpath("//div[@id='result-stats']/text()").text.delete('^0-9').to_i,
        search_time: doc.xpath("//div[@id='result-stats']/nobr/text()").text.delete('^0-9.').to_f,
        total_links: doc.xpath('//a/@href').count,
        total_ads: doc.xpath("//div[@aria-label='Ads']/div").count,
        source: browser.html,
        status: :finished,
      )
      browser.quit
      raise Net::ReadTimeout
    rescue Net::ReadTimeout
      crawl_result.update!(status: :failed)
    end

    def proxy(index)
      {
        http: "#{Settings.proxy.username}:#{Settings.proxy.password}@#{Settings.proxy.proxies[index]}",
        ssl: "#{Settings.proxy.username}:#{Settings.proxy.password}@#{Settings.proxy.proxies[index]}"
      }
    end

    def create_notification
      notification = Notification.create(user_id: user_id, content: "Failed to crawl keyword: #{keyword}")
      ActionCable.server.broadcast('notification_channel', notification.content)
    end
  end
end
