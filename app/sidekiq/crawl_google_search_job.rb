class CrawlGoogleSearchJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(keyword, user_id, proxy_index)
    Scraper::CrawlGoogleSearchService.call(keyword, user_id, proxy_index)
  end
end
