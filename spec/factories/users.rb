FactoryBot.define do
  factory :user do
    name { "tester" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "2423abc" }
    gender { "0" }
    age { "20" }
  end
end
