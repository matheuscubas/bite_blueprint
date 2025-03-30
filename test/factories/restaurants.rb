# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.unique.name }
    description { Faker::Restaurant.description }
    category { Faker::Restaurant.type }
  end
end
