module Scraper
  class CrawlJobCallbackService
    def on_success(status, options)
      # TODO: create notification here
      # Rails.cache.read("#{options['batch_id']}_FAILED_KEYWORDS")
    end
  end
end
