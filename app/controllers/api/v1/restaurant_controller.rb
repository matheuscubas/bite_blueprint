module Api
  module V1
    class RestaurantController < ApplicationController
      def index
        restaurants = Restaurant.includes(menus: :menu_items).all

        if restaurants.any?
          render json: RestaurantRepresenter.for_collection.new(restaurants), status: 200
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end

      def show
        restaurant = Restaurant.find_by(id: params[:id])

        if restaurant
          render json: RestaurantRepresenter.new(restaurant), status: 200
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end
    end
  end
end
