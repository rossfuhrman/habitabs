class MeasuredHabit < ApplicationRecord
  validates_presence_of :title, :user
  belongs_to :user
  has_many :measurements, :dependent => :destroy

  acts_as_list

  def self.measurement_options
    ["Marks", "Minutes", "Hours", "Miles", "Meters", "Yards", "Kilometers", "Feet", "Pounds", "Kilograms", "Calories", "Other"]
  end

  def self.measurement_options_for_account_setup
    measurement_options.reject{|option| option  == "Marks"}
  end

  def get_measurement_value date
    measurements_on_date = measurements.select{|m| m.measurement_date == date}
    value = if measurements_on_date.any?
              measurements_on_date.first.value
            else
              ""
            end
  end

  def polarity_class
    Polarity.polarity_class polarity
  end
end
