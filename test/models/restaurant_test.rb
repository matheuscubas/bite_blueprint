# test/models/restaurant_test.rb
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  test "should be valid with required attributes" do
    restaurant = build(:restaurant)
    assert restaurant.valid?
  end

  test "should require name" do
    restaurant = build(:restaurant, name: nil)
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:name], "can't be blank"
  end

  test "should enforce unique case-insensitive names" do
    create(:restaurant, name: "Burger Palace")
    restaurant = build(:restaurant, name: "burger palace")
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:name], "has already been taken"
  end

  test "should accept nested attributes for menus" do
    restaurant = build(:restaurant, menus_attributes: [ {
                                                         name: "Lunch",
                                                         menu_items_attributes: [
                                                           { name: "Burger", price: 9.99 },
                                                           { name: "Salad", price: 7.50 }
                                                         ]
                                                       } ])
    assert restaurant.valid?
  end

  test "should validate associated menus" do
    restaurant = build(:restaurant, menus_attributes: [ {
                                                         name: "" # Invalid menu
                                                       } ])
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:menus], "is invalid"
  end

  test "should have menu_items through menus" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    menu_item = create(:menu_item, menus: [ menu ])

    assert_includes restaurant.menu_items, menu_item
  end

  test "should accept optional description and category" do
    restaurant = build(:restaurant, description: nil, category: nil)
    assert restaurant.valid?
  end

  test "should reject duplicate menu names within same restaurant" do
    restaurant = create(:restaurant)
    create(:menu, name: "Dinner", restaurant: restaurant)

    duplicate_menu = build(:menu, name: "Dinner", restaurant: restaurant)
    restaurant.menus << duplicate_menu

    assert_not restaurant.valid?
    assert_includes restaurant.errors[:menus], "is invalid"
  end
end
