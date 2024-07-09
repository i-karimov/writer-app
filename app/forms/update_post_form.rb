class UpdatePostForm
  include ActiveModel::Model

  attr_reader :post, :params, :status

  validates :post, presence: true
  validate :status_permitted_transition, if: :status_changed?

  def initialize(post, params = {})
    @post = post
    @params = params
    @status = params[:status]
  end

  def perform
    return false unless valid?

    post.transaction do
      post.update(params.except(:attachments, :status))
      post.attachments.attach(params[:attachments])

      UpdatePostStatusJob.perform_later(post.id, aasm_event) if status_changed?
    end
    errors.merge!(post.errors)
    errors.empty?
  end

  def status_changed?
    status.present? && post.status != params[:status]
  end

  def status_permitted_transition
    return if post.aasm.permitted_transitions.map { |tr| tr[:state] }.include?(status&.to_sym)

    errors.add(:status, "Transition is not permitted: #{status}")
  end

  def aasm_event
    event_mapping = {
      on_moderation: :submit,
      approved: :approve,
      rejected: :reject
    }

    event_mapping[status.to_sym]
  end
end
