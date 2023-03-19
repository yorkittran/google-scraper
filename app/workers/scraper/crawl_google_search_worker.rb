module Scraper
  class CrawlGoogleSearchWorker
    include Sidekiq::Worker
    sidekiq_options retry: 1

    def perform(keywords, user_id, batch_id)
      CrawlGoogleSearchService.call(keywords, user_id, batch_id)
    end
  end
end
