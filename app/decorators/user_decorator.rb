class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    name = [object.first_name, object.middle_name, object.last_name]

    name.join(' ')
  end

  def short_name
    [object.first_name[0], object.last_name].join('. ')
  end

  def registration_date
    object.created_at.strftime('%A, %B %e')
  end
end
