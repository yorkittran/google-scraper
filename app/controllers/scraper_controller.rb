class ScraperController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def search
    Scraper::SearchService.call(search_params[:file], current_user.id)

    redirect_to root_path, notice: 'Successfully upload file, please wait a little bit to get result in History'
  end

private

  def search_params
    params.require(:file)
    params.permit(:file)
  end
end
