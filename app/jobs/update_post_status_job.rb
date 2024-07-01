class UpdatePostStatusJob < ApplicationJob
  queue_as :default

  def perform(post_id, event)
    post = Post.find(post_id)
    Rails.logger.info("Start updating status: #{post.status}, event: #{event}")
    UpdatePostStatusService.call(post, event)
  rescue StandardError => e
    Rails.logger.error("Error updating post status in background job: #{e.message}")
  end
end
