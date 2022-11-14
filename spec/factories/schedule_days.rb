FactoryBot.define do
  factory :schedule_day do
    week { 1 }
    begin_time { 10 }
    end_date { 14 }
    active { true }
    week_day { 0 }
    date { Date.today.beginning_of_week }
    service
  end
end
