module Scraper
  class CrawlJobCallbackService
    def on_success(status, options)
      puts '---- SUCCESS ----'
      puts status, options
      puts '-----------------'
    end
  end
end
