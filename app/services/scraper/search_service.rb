module Scraper
  class SearchService < ApplicationService
    def initialize(csv_file)
      @csv_file = csv_file
    end

    def call
      puts 'oke'
    end

  private

    attr_reader :csv_file
  end
end
