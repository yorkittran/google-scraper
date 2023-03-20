class AddStatusInNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :status, :integer, null: false, default: 0, after: :content
  end
end
