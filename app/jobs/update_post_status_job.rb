class UpdatePostStatusJob < ApplicationJob
  queue_as :default

  def perform(post_id, event)
    post = Post.find_by(id: post_id)
    return unless post
    Rails.logger.info("Start updating status: #{post.status}, event: #{event}")
    UpdatePostStatusService.call(post, event)
  rescue => e
    Rails.logger.error("Error updating post status in background job: #{e.message}")
  end
end