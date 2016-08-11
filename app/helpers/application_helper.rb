module ApplicationHelper
  #returns the full title on a per-page basis when one is not supplied.

  def full_title(page_title =  '')
    base_title = "Ruby on Rails Tutorial App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
