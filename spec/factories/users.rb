FactoryBot.define do
  factory :user do
    email { "#{Faker::Internet.unique.username}@example.com" }
    password { "123456" }
  end
end
