module ApplicationHelper
  def nav_class(current_page, item)
    if current_page == item
      return "current_page_item"
    else
      return ""
    end
  end
end
