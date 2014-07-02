class Habit < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :marks , :dependent => :destroy

  acts_as_list

  #NEEDS TO BE TESTED
  def marks_on_date date
    count = marks.where(:mark_date => date).count
    if count == 0
      ""
    else
      count
    end
  end
  
  #NEEDS TO BE TESTED
  def mark_total an_date
    the_count = marks.select{|f| f.mark_date == an_date}.count
    the_count == 0 ? "" : the_count 
  end

  NEUTRAL = 0
  POSITIVE = 1
  NEGATIVE = 2

  #NEEDS TO BE TESTED
  def mark_value count_of_marks
    if polarity == POSITIVE
      count_of_marks
    elsif polarity == NEGATIVE
      count_of_marks * -1
    else
      0
    end
  end

  #NEEDS TO BE TESTED
  def mark_sum_for date
    count = mark_total(date).to_i 
    mark_value(count)
  end


  def polarity_class
    if polarity == POSITIVE
      "positive"
    elsif polarity == NEGATIVE
      "negative"
    else
      "neutral"
    end
  end

end
