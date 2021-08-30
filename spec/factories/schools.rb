FactoryBot.define do
  factory :school do
    name {Faker::Nation.capital_city}
    seats {Faker::Number.number(digits: 2)}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
  end
end
