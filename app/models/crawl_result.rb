# == Schema Information
#
# Table name: crawl_results
#
#  id            :bigint           not null, primary key
#  keyword       :string           not null
#  search_time   :float            default(0.0), not null
#  source        :text
#  status        :integer          default("pending"), not null
#  total_ads     :integer          default(0), not null
#  total_links   :integer          default(0), not null
#  total_results :bigint           default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_crawl_results_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CrawlResult < ApplicationRecord
  CSV_LIMIT_LINES = 100

  belongs_to :user

  module Status
    ALL = %i[pending successful failed].freeze

    pending = 'pending'.freeze
    successful = 'successful'.freeze
    failed = 'failed'.freeze
  end

  enum status: Status::ALL
end
