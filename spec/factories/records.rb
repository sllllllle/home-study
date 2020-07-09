FactoryBot.define do
  factory :record do
    association :user 
    label { "everyday rails完走" }
    finished { false }
    start_time { "2000-01-01 02:11:21" }
  end
end
