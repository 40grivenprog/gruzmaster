FactoryBot.define do
  factory :role do
    trait :admin do
      name { "admin" }
      description { "System Admin" }
    end
    name { "user" }
    description { "User" }
  end
end
