class Api::V1::RestaurantController < ApplicationController
  def index
    restaurants = Restaurant.all

    if restaurants.any?
      render json: restaurants, status: 200
    else
      render json: { error: "No menu found please try again later" }, status: :not_found
    end
  end

  def show
    restaurant = Restaurant.find_by(id: params[:id])

    if restaurant
      render json: restaurant, status: 200
    else
      render json: { error: "No menu found please try again later" }, status: :not_found
    end
  end
end
