require "test_helper"

class Api::V1::RestaurantControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_restaurant_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_restaurant_show_url
    assert_response :success
  end
end
