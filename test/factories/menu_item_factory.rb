# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.unique.dish  }
    description  { Faker::Food.description }
    price { Faker::Number.number(digits: 4) }
    association :menu, factory: :menu
  end
end
