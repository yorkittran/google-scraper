class CrawlResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_crawl_result, only: :show

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

  def show; end

private

  def set_crawl_result
    @crawl_result = CrawlResult.find(params[:id])
  end
end
