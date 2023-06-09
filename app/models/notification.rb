# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  content    :string           default(""), not null
#  status     :integer          default("unread"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  NEWEST_LIMIT = 10

  belongs_to :user

  scope :for_display, -> { order(:created_at).last(NEWEST_LIMIT) }

  module Status
    ALL = %i[unread read].freeze

    unread = 'unread'.freeze
    read = 'read'.freeze
  end

  enum status: Status::ALL
end
