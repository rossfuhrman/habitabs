require 'date'
class DateHelper
  def initialize(date)
    @date = date
  end
  def date
    @date
  end
  def to_date
    date.strftime
  end
  def is_today?
    date == Date.today
  end
  def in_the_future?
    date > Date.today
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
