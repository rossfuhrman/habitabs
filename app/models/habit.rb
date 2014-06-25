class Activity < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :marks , :dependent => :destroy
  def marks_on_date date
    count = marks.where(:mark_date => date).count
    if count == 0
      ""
    else
      count
    end
  end

  NEUTRAL = 0
  POSITIVE = 1
  NEGATIVE = 2

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
