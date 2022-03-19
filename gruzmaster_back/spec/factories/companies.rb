FactoryBot.define do
  factory :company do
    company_name { Faker::Company.name }
    company_description { Faker::Company.industry }
    
    trait :invalid do
      company_name { nil }
    end
  end
end
