module ApplicationHelper

  def js_dates(dates)
    raw(dates.map{ |d| d.strftime("%Y-%-m-%-d") })
  end

end
