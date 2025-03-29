module Api
  module V1
    class MenuController < ApplicationController
      def index
        menus = Menu.includes(:menu_items).all

        if menus.any?
          render json: menus_with_menu_items(menus:), status: :ok
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end

      def show
        menu = Menu.includes(:menu_items).find_by(id: params[:id])

        if menu
          render json: menu_representer(menu:), status: :ok
        else
          render json: { error: "No menu found please try again later" }, status: :not_found
        end
      end

      private

      def menus_with_menu_items(menus:)
        return { menus: } if menus.empty?

        menus.map do |menu|
          result = menu_representer(menu:)

          result
        end
      end

      def menu_representer(menu:)
        result = menu.attributes.symbolize_keys
        result[:created_at] = result[:created_at].strftime("%Y-%m-%d")
        result[:updated_at] = result[:updated_at].strftime("%Y-%m-%d")
        result[:menu_items] = menu.menu_items.map { |menu_item| menu_item_representer(menu_item:) }

        result
      end

      def menu_item_representer(menu_item:)
        result = menu_item.attributes.symbolize_keys
        result[:created_at] = result[:created_at].strftime("%Y-%m-%d")
        result[:updated_at] = result[:updated_at].strftime("%Y-%m-%d")
        result[:price] = result[:price] / 100.0

        result.except(:menu_id)
      end
    end
  end
end
