require "test_helper"

class Api::V1::MenuControllerTest < ActionDispatch::IntegrationTest
  test "Should return a list of Menus" do
    create_list(:menu, 5)

    get api_v1_menu_index_url
    body = JSON.parse(@response.body)

    assert body.size == 5
    assert body.first["menu_items"].present?
    assert_response :success
  end

  test "Should return 404 if no Menu is found" do
    get api_v1_menu_index_url
    body = JSON.parse(@response.body)

    assert body["error"].present?
    assert_response :not_found
  end

  test "Should get show" do
    menu = create(:menu)

    get api_v1_menu_url(menu.id)
    body = JSON.parse(@response.body)

    assert body.first["menu_items"].present?
    assert_response :success
  end

  test "Should return 404 if not Menu is found" do
    get api_v1_menu_url(1)
    body = JSON.parse(@response.body)

    assert body["error"].present?
    assert_response :not_found
  end
end
