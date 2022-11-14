FactoryBot.define do
  factory :schedule_block do
    hour { 10 }
    status { nil }
    schedule_day
  end
end
