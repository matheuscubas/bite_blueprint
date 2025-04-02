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

      def create
        restaurants_params = restaurant_params.map(&:to_hash)
        result = CreateRestaurantService.call(restaurants_params)
        response = if result.is_a?(Array)
                     restaurants = []

                     result.each do |result_object|
                       if result_object[:error].present?
                         render json: { error: result_object[:error], message: "Restaurant #{result_object[:restaurant].inspect}" }, status: :unprocessable_entity and return
                       else
                         restaurants << result_object[:restaurant]
                       end
                     end

                     { restaurants: RestaurantRepresenter.for_collection.new(restaurants), status: :ok } if restaurants.any?
        else
                     if result[:error].present?
                       render json: { error: result[:error], message: "Restaurant #{result[:restaurant].inspect}, is invalid" }, status: :unprocessable_entity and return
                     else
                       { restaurant: RestaurantRepresenter.new(result[:restaurant]), status: :ok }
                     end
        end

        render json: response
      end

      private

      def restaurant_params
        params.require(:restaurants).map do |restaurant|
          restaurant.permit(
            :name,
            :description,
            :category,
            menus: [
              :name,
              :description,
              menu_items: [
                :name,
                :price,
                :description
              ]
            ]
          )
        end
      end
    end
  end
end
