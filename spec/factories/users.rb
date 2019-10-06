FactoryGirl.define do
  factory :user do
    sequence(:user) { |n| "test#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    password 'password'
    password_confirmation 'password'
  end
end
