class ScraperController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    service = Scraper::SearchService.call(search_params[:file])

    redirect_to root_path, notice: 'Successfully upload file, please wait a little bit to get result in History'
  end

  private

  def search_params
    params.require(:file)
    params.permit(:file)
  end
end
