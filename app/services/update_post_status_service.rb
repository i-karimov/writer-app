class UpdatePostStatusService
  def self.call(post, event)
    post.aasm.fire!(event)
  rescue AASM::InvalidTransition => e
    Rails.logger.error("Invalid transition: #{e.message}")
    false
  rescue StandardError => e
    Rails.logger.error("Error updating post status: #{e.message}")
    false
  end
end
