# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.unique.name }
    description { Faker::Restaurant.description }
    category { Faker::Restaurant.type }
  end

  trait :with_menus do
    after(:create) do |restaurant|
      create_list(:menu, 2, restaurant: restaurant)
    end
  end
end
