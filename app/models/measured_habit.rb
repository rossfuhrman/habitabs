class MeasuredHabit < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :measurements, :dependent => :destroy

  acts_as_list

  def self.measurement_options
    ["Marks", "Minutes", "Hours", "Miles", "Meters", "Yards", "Kilometers", "Feet", "Pounds", "Kilograms", "Calories"]
  end

  def get_measurement_value date
    foo = measurements.select{|m| m.measurement_date == date}
    if foo.any?
      foo.first.value
    else
      return ""
    end
  end

  #duplicated from habit.rb :( :( :(
  def polarity_class
    return "positive" if polarity == POSITIVE
    return "negative" if polarity == NEGATIVE
    "neutral"
  end

  #duplicated from habit.rb :( :( :(
  NEUTRAL = 0
  POSITIVE = 1
  NEGATIVE = 2
end
