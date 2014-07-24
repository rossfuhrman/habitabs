# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measured_habit do
    title "MyString"
    private false
    references ""
    polarity 1
    description "MyText"
    postion 1
    measurement_type "MyString"
  end
end
