FactoryBot.define do
  factory :user, aliases: [:agent] do
    first_name { 'John' }
    last_name  { 'Doe' }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    admin { false }
  end
end
