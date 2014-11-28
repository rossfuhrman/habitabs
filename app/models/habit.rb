class Habit < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :marks , :dependent => :destroy

  NEUTRAL = 0
  POSITIVE = 1
  NEGATIVE = 2

  acts_as_list

  def streak
    @streak ||= Streak.new self
  end

  #this is for a singular habit that hasn't :include marks
  #and it is for a specific date
  #the mark_total has a habit that has all the marks included anyways
  #so limiting it to a specific date with a where call
  #won't provide any perf increases
  def marks_on_date date
    the_count = marks.where(mark_date: date).count
    the_count == 0 ? "" : the_count 
  end
  
  #this is for a collection of habits that did an :include of marks,
  #so we don't want to do another query to get them
  def mark_total an_date
    the_count = marks.select{|m| m.mark_date == an_date}.count
    the_count == 0 ? "" : the_count 
  end

  def mark_value count_of_marks
    return 0 if polarity == NEUTRAL
    return count_of_marks * -1 if polarity == NEGATIVE
    count_of_marks
  end

  def mark_sum_for date
    count = mark_total(date).to_i 
    mark_value(count)
  end

  def polarity_class
    return "positive" if polarity == POSITIVE
    return "negative" if polarity == NEGATIVE
    "neutral"
  end

end
