# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :habit do
    user { User.where(email: 'test@example.com').first || FactoryGirl.create(:user) }
    title "MyString"
    private false
    polarity "MyString"

    factory :other_users_habit do
      user { User.where(email: 'otheruser@example.com').first || FactoryGirl.create(:other_user) }
      title "otherMyString"
      private false
      polarity "MyString"
    end
  end
end
