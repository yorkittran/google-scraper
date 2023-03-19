class ScraperController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def search
    service = Scraper::CreateCrawlJobService.new(search_params[:file], current_user.id)
    service.call

    if service.error
      redirect_to root_path, flash: { error: service.error }
    else
      redirect_to root_path, notice: 'Successfully upload file, please wait a couple minutes to get results in History'
    end
  end

private

  def search_params
    params.require(:file)
    params.permit(:file)
  end
end
