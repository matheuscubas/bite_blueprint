# frozen_string_literal: true

class CreateRestaurantService < ApplicationService
  def call(params)
    is_batch = params.is_a?(Array) && params.size > 1
    sanitized_data = is_batch ? sanitize_batch(params:) : sanitize_data(params: params)

    case is_batch
    when true
      restaurants = sanitized_data.map do |restaurant_data|
        prepare_nested_attributes(restaurant_data:)
      end

      restaurants.map do |restaurant|
        result(restaurant:)
      end
    else
      restaurant = prepare_nested_attributes(restaurant_data: sanitized_data)
      result(restaurant:)
    end
  end

  private

  def sanitize_batch(params:)
    params.map do |restaurant_params|
      sanitize_data(params: restaurant_params)
    end
  end

  def sanitize_data(params:)
    params = params.first if params.is_a?(Array)

    JsonValidator.new(params).parsed_json
  end

  def prepare_nested_attributes(restaurant_data:)
    Restaurant.new({
                     name: restaurant_data[:name],
                     menus_attributes: restaurant_data[:menus]&.map do |menu|
                       {
                         name: menu[:name],
                         menu_items_attributes: menu[:menu_items]&.map do |item|
                           {
                             name: item[:name],
                             price: to_cents(price: item[:price])
                           }
                         end
                       }.compact
                     end
                   }.compact)
  end

  def validate_restaurant(restaurant:)
    restaurant.valid?
  end

  def result(restaurant:)
    return { error: restaurant.errors.full_messages, restaurant: } unless restaurant.valid?

    restaurant.save

    { restaurant: }
  end

  def to_cents(price:)
    (price.to_f * 100).to_i
  end
end
