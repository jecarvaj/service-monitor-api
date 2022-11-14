FactoryBot.define do
  factory :service do
    name { 'Monitoreo X' }
    init_date { Date.today.beginning_of_week }
    end_date { Date.today.end_of_week }
    company
  end
end
