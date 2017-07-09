# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measured_habit do
    user { User.where(email: 'test@example.com').first || FactoryGirl.create(:user) }
    title "MyString"
    private false
    polarity 1
    description "MyText"
    position 1
    measurement_type "MyString"

    factory :other_users_measured_habit do
      user { User.where(email: 'otheruser@example.com').first || FactoryGirl.create(:other_user) }
      title "other measured Habit"
      private false
      polarity "MyString"
    end
  end
end
