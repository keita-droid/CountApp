FactoryBot.define do
  factory :month do
    month {Time.current.beginning_of_month}
  end
end
