module PostsHelper
  def status_badge_class(status)
    'badge rounded-pill text-bg-' + case status
                                    when 'draft'
                                      'secondary'
                                    when 'on_moderation'
                                      'warning'
                                    when 'approved'
                                      'success'
                                    when 'rejected'
                                      'danger'
                                    end
  end
end
