# == Schema Information
#
# Table name: crawl_results
#
#  id            :bigint           not null, primary key
#  keyword       :string           not null
#  search_time   :float            default(0.0), not null
#  source        :text
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
  belongs_to :user
end
