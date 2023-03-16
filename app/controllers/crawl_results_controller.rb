class CrawlResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    @crawl_results = current_user.crawl_results
  end
end
