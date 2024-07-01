class PostForm
  include ActiveModel::Model

  attr_accessor :post, :params

  validates :post, presence: true

  def update
    Post.transaction do
      raise ActiveRecord::Rollback unless post.update!(params.except(:images, :files))

      post.images.attach(params[:images]) unless post.images.attached?
      post.files.attach(params[:files]) unless post.files.attached?
      post
    end
  rescue ActiveRecord::StaleObjectError
    errors.add(:base, 'Post was updated by another user. Please refresh the page and try again.')
  rescue ActiveRecord::Rollback
    errors.merge!(post.errors)
  end
end
