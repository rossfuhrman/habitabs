# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measured_habit do
		user
    title "MyString"
    private false
    polarity 1
    description "MyText"
    position 1
    measurement_type "MyString"
  end
end
