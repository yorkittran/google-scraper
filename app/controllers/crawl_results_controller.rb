class CrawlResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query]
      @crawl_results = current_user.crawl_results.where("keyword LIKE ?", "%#{params[:query].strip}%")
    else
      @crawl_results = current_user.crawl_results
    end

    if turbo_frame_request?
      render partial: 'crawl_results', locals: { crawl_results: @crawl_results }
    else
      render :index
    end
  end
end
