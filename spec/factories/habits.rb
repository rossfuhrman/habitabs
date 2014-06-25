# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :habit do
    title "MyString"
    private false
    polarity "MyString"

    factory :other_users_habit do
      user other_user
      title "otherMyString"
      private false
      polarity "MyString"
    end
  end
end
