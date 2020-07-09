FactoryBot.define do
  factory :micropost do
    association :user
    content { "テスト投稿です" }
  end
end
