require 'csv'

module Scraper
  class SearchService < ApplicationService
    def initialize(csv_file)
      @csv_file = csv_file
    end

    def call
      Rails.logger.debug 'oke'
    end

  private

    attr_reader :csv_file
  end
end
