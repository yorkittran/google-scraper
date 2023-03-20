module Scraper
  class CrawlJobCallbackService
    def on_success(status, options)
      create_notification(options['user_id'], options['batch_id'])
    end

  private

    def create_notification(user_id, batch_id)
      failed_keywords = Rails.cache.read("#{batch_id}_FAILED_KEYWORDS")
      notification = if failed_keywords.present?
        Notification.create(user_id: user_id, content: "Failed to crawl some keywords: #{failed_keywords.join(', ')}")
      else
        Notification.create(user_id: user_id, content: 'Successfully crawl all keywords!')
      end
      ActionCable.server.broadcast('notification_channel', notification.content)
    end
  end
end
