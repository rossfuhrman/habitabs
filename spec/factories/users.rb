# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'
    password_confirmation 'password'

    factory :other_user do
      email 'otheruser@example.com'
      password 'password'
      password_confirmation 'password'
    end
  end
end
