# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { "#{Faker::Food.dish} - #{Faker::Food.ethnic_category} way" }
    description  { Faker::Food.description }
    price { Faker::Number.number(digits: 4) }
  end
end
