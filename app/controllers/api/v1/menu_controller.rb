module Api
  module V1
    class MenuController < ApplicationController
      def index
        menus = Menu.includes(:menu_items).all

        if menus.any?
          render json: MenuRepresenter.for_collection.new(menus), status: :ok
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end

      def show
        menu = Menu.includes(:menu_items).find_by(id: params[:id])

        if menu
          render json: MenuRepresenter.new(menu), status: :ok
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end
    end
  end
end
