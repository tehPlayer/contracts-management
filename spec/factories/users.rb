FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    full_name { 'John Doe' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
