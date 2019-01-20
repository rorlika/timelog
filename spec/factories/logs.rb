FactoryBot.define do
  factory :log do
    user
    project
    hours { Faker::Number.between(1, 10) }
    log_date { Faker::Date.between(2.days.ago, Date.today) }
  end
end
