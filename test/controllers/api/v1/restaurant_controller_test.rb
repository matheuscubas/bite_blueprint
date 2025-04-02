require "test_helper"

module Api
  module V1
    class RestaurantControllerTest < ActionDispatch::IntegrationTest
      # Index Tests
      test "should return all restaurants with nested data" do
        create_list(:restaurant, 3, :with_menus)

        get api_v1_restaurant_index_url
        assert_response :success

        body = JSON.parse(response.body, symbolize_names: true)
        assert_equal 3, body.size
        assert body.first.key?(:menus)
        assert body.first[:menus].first.key?(:menu_items)
      end

      test "should return not found when no restaurants exist" do
        get api_v1_restaurant_index_url
        assert_response :not_found
        assert_equal "No menu found please try again later", JSON.parse(response.body)["error"]
      end

      # Show Tests
      test "should return a specific restaurant" do
        restaurant = create(:restaurant, :with_menus)

        get api_v1_restaurant_url(restaurant.id)
        assert_response :success

        body = JSON.parse(response.body, symbolize_names: true)
        assert_equal restaurant.name, body[:name]
        assert body.key?(:menus)
      end

      test "should return not found when restaurant doesn't exist" do
        get api_v1_restaurant_url(999)
        assert_response :not_found
        assert_equal "No menu found please try again later", JSON.parse(response.body)["error"]
      end

      # Create Tests
      test "should creates restaurant with valid params" do
        valid_params = {
          restaurants: [ {
                          name: "New Restaurant",
                          menus: [ {
                                    name: "Lunch",
                                    menu_items: [ {
                                                   name: "Burger",
                                                   price: 9.99
                                                 } ]
                                  } ]
                        } ]
        }

        assert_difference("Restaurant.count", 1) do
          post api_v1_restaurant_index_url, params: valid_params, as: :json
        end

        assert_response :success
        assert_equal "New Restaurant", JSON.parse(response.body)["restaurant"]["name"]
      end

      test "POST create - returns error for invalid params" do
        invalid_params = {
          restaurants: [ {
                          name: "",
                          menus: [ {
                                    name: "Lunch",
                                    menu_items: [ {
                                                   name: "Burger",
                                                   price: 9.99
                                                 } ]
                                  } ]
                        } ]
        }

        post api_v1_restaurant_index_url, params: invalid_params, as: :json

        assert_response :unprocessable_entity
        assert JSON.parse(response.body)["error"].present?
      end

      test "POST create - requires restaurants param" do
        post api_v1_restaurant_index_url, params: {}, as: :json

        assert_response :bad_request
      end
    end
  end
end
