# frozen_string_literal: true

FactoryBot.define do
  factory :menu do
    name { "#{Faker::Restaurant.name} - #{Faker::Food.ethnic_category}" }
    description  { Faker::Food.description }
    association :restaurant, factory: :restaurant

    after(:create) { |menu| FactoryBot.create_list(:menu_item, 5, menus: [ menu ]) }
  end
end
