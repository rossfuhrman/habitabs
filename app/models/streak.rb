class Streak

  BROKEN = 0
  YESTERDAY = 1
  TODAY = 2

  def initialize habit
    @habit = habit
    @marks_by_date = @habit.marks.to_a.uniq(&:mark_date).sort_by(&:mark_date)
    @streak_duration = get_streak_duration
  end
  def streak_duration
    @streak_duration
  end
  
  #oh yeah, I want to use the value to do something in the UI
  #to indicate this streak is in progress or not
  #but I am not currently doing that
  def status
    return BROKEN if streak_duration == ""
    latest = @marks_by_date.last
    latest.mark_date == Time.current.to_date ? TODAY : YESTERDAY
  end

  private

  def get_streak_duration
    count = 0
    marks_reversed = @marks_by_date.reverse
    #we have to handle today separately because a streak is considered 'active'
    #if the latest mark is today or yesterday
    if marks_reversed.any? && marks_reversed.first.mark_date == Time.current.to_date
      count += 1
      marks_reversed.shift
    end
    #now we can loop through the remaining unique marks 
    #and look for the first gap
    date_to_check = Time.current.to_date - 1
    marks_reversed.each do |mark|
      if mark.mark_date == date_to_check
        count += 1
        date_to_check -= 1
      else
        break
      end
    end
    count == 0 ? "" : count
  end
end
