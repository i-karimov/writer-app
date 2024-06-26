module ApplicationHelper
  def nav_tab(title, url, options = {})
    current_page = options.delete(:current_page)
    options[:class] += ' text-white bg-warning' if current_page == title

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: }
  end
end
