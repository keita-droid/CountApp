FactoryBot.define do
  factory :business_hour do
    current_stay { 0 }
    maximum_stay { 0 }
    coming { 0 }
    leaving { 0 }
    leave_count { 0 }
    hour { 16 }
    association :business_day
  end
end
