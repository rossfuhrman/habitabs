# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal do
    entry "MyText"
    date "2014-08-29"
    user { User.where(email: 'test@example.com').first || FactoryGirl.create(:user) }

    factory :other_users_journal do
      user { User.where(email: 'otheruser@example.com').first || FactoryGirl.create(:other_user) }
      entry "other user journal entry"
      date Date.today
    end
  end
end
