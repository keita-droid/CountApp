FactoryBot.define do
  factory :business_day do
    date { Time.current }
    weekend_operation { false }
    association :school
    association :month
  end
end
