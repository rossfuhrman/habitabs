# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal do
    entry "MyText"
    date "2014-08-29"
    user_id 1
  end
end
