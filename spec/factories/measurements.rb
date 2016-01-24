# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measurement do
    value "9.99"
		measurement_date Date.today
  end
end
