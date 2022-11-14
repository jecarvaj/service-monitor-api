users = [
  { first_name: 'Admin', last_name: 'Istrador', email: 'admin@email.com', password: '12345678',
    password_confirmation: '12345678', is_admin: true },
  { first_name: 'Ernesto', last_name: 'E', email: 'ernesto@email.com', password: '12345678',
    password_confirmation: '12345678' },
  { first_name: 'Barbara', last_name: 'C', email: 'barbara@email.com', password: '12345678',
    password_confirmation: '12345678' },
  { first_name: 'Benjamin', last_name: 'D', email: 'benjamin@email.com', password: '12345678',
    password_confirmation: '12345678' }
]

puts "Generated #{users.size} users!" if User.create(users)

companies = [
  { name: 'Facebook' },
  { name: 'Recorrido' },
  { name: 'Twitter' }
]

puts "Generated #{companies.size} companies!" if Company.create(companies)

services = [
  { name: 'Special 1', init_date: '2022-10-01'.to_date.beginning_of_week, end_date: '2022-12-31'.to_date.end_of_week,
    company: Company.first },
  { name: 'Cyber', init_date: '2022-11-01'.to_date.beginning_of_week, end_date: '2022-12-31'.to_date.end_of_week,
    company: Company.second },
  { name: 'Service X', init_date: '2022-06-01'.to_date.beginning_of_week, end_date: '2022-12-31'.to_date.end_of_week,
    company: Company.third }
]

service_days = [
  { "0": [19, 0], "1":  [19, 0], "2":  [19, 0], "3":  [19, 0], "4": [19, 0], "5": [10, 0], "6": [10, 0] },
  { "0": [10, 18], "1": [10, 18], "2": [10, 18], "3": [10, 18], "4": [18, 23], "5": [], "6": [] },
  { "0": [8, 12], "1": [8, 12], "2": [8, 12], "3": [8, 12], "4": [8, 12], "5": [19, 23], "6": [19, 23] }
]

puts 'Going Services whith their schedules...'

services.each_with_index do |s, index|
  s = Service.new(s)
  GenerateScheduleService.call(s, service_days[index])
  s.save
end

puts "Generated #{Service.all.size} services with their schedules and availability!"
