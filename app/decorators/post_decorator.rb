class PostDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def published_at_formatted
    return 'unpublished' if published_at.blank?

    object.published_at.strftime('%d %b %Y, %H:%M')
  end
end
