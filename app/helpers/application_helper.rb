module ApplicationHelper
  def nav_class(current_page, item)
    if current_page == item
      return "current_page_item"
    else
      return ""
    end
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display:none"
    end
      content_tag("div", attributes, &block)
    end
  end

  def logged_user
    return false
  end
