FactoryBot.define do
  factory :business_day do
    date {Faker::Date.between(from: '2021-09-01', to: '2021-09-30') }
    weekend_operation { false }
    association :school
    association :month
  end
end
