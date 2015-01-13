require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :voter do
    sequence(:first_name) { |n| "John #{n}" }
    last_name "Doe"
    sequence(:address1) { |n| "#{n} Somerville Ave." }
    city "Somerville"
    state "MA"
    zip "02143"
  end

  factory :list do
    sequence(:name) { |n| "Sample list #{n}" }

    after(:create) do |list|
      10.times { list.voters << create(:voter) }
    end
  end
end
