require "test_helper"

module Api
  module V1
    class RestaurantControllerTest < ActionDispatch::IntegrationTest
      test "Should return a list of restaurants" do
        create_list(:restaurant, 5)

        get api_v1_restaurant_index_url
        body = JSON.parse(@response.body, symbolize_names: true)

        assert body.size == 5
        assert body.first[:name] == Restaurant.first.name
        assert_response :success
      end

      test "Should return a specific restaurant" do
        create(:restaurant)

        get  api_v1_restaurant_url(1)
        body = JSON.parse(@response.body, symbolize_names: true)

        assert body[:name] == Restaurant.first.name
        assert_response :success
      end
    end
  end
end
