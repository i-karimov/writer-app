module ApplicationHelper
  def nav_tab(title, url, options = {})
    current_page = options.delete(:current_page)

    options[:class] += ' bg-primary text-white' if current_page == title
    puts '*' * 30
    puts title, url, options
    puts '*' * 30
    puts current_page

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: }
  end
end
