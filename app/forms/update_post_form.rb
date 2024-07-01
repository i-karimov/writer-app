class UpdatePostForm
  include ActiveModel::Model

  attr_reader :post, :params, :status

  validates :post, presence: true
  validate :status_permitted_transition

  def initialize(post, params = {})
    @post = post
    @params = params
    @status = params[:status]
  end

  def perform
    return false unless valid?

    post.transaction do
      post.update(params.except(:images, :files, :state))
      post.images.attach(params[:images]) unless post.images.attached?
      post.files.attach(params[:files]) unless post.files.attached?

      UpdatePostStatusJob.perform_later(post.id, aasm_event)
    end
    errors.merge!(post.errors)
    errors.empty?
  end

  def status_permitted_transition
    return if post.aasm.permitted_transitions.map { |tr| tr[:state] }.include?(status&.to_sym)

    errors.add(:status, "Transition is not permitted: #{status}")
  end

  def aasm_event

    transitions = post.aasm.permitted_transitions
    event = transitions.detect { |tr| tr[:state] == status&.to_sym }
    event
  end
end
