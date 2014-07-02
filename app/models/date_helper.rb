require 'date'
class DateHelper
  def initialize(date)
    @date = date
  end
  def date
    @date
  end

  attr_accessor :mark_total

  def to_date
    date.strftime
  end
  def is_today?
    date == Time.current.to_date 
  end
  def in_the_future?
    date > Time.current.to_date
  end
  def display_class
    return "today" if is_today?
    return "future" if in_the_future?
    "past"
  end
  def day_of_week
    Date::DAYNAMES[date.wday]
  end
  def day_of_week_abbreviated
    Date::ABBR_DAYNAMES[date.wday]
  end
end
