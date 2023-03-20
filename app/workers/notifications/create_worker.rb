module Notifications
  class CreateWorker
    include Sidekiq::Worker
    sidekiq_options retry: 1

    def perform(notification_id)
      notification = Notification.find(notification_id)
      ActionCable.server.broadcast('notification_channel', notification.content)
      ActionCable.server.broadcast('notification_channel', 'hello')
    end
  end
end
