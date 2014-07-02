class DateRange
  #replaced Date.today
  def initialize(supplied_start_date = Time.current.to_date)
    @supplied_start_date = supplied_start_date
    set_days
  end
  def start_date
    @supplied_start_date - @supplied_start_date.wday
  end
  attr_accessor :days
  def set_days
    the_days = []
    7.times do |i|
      the_days << DateHelper.new(start_date + i)
    end
    @days = the_days
  end
  def previous_week_start_date
    days[0].date - 7
  end
  def next_week_start_date
    days[0].date + 7 unless days[0].date + 7 > Time.current.to_date
  end
end
