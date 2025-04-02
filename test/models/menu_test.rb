# test/models/menu_test.rb
require "test_helper"

class MenuTest < ActiveSupport::TestCase
  test "should be valid with required attributes" do
    menu = build(:menu)
    assert menu.valid?
  end

  test "should require name" do
    menu = build(:menu, name: nil)
    assert_not menu.valid?
    assert_includes menu.errors[:name], "can't be blank"
  end

  test "should enforce unique names within same restaurant" do
    restaurant = create(:restaurant)
    create(:menu, name: "Dinner", restaurant: restaurant)
    duplicate_menu = build(:menu, name: "Dinner", restaurant: restaurant)
    assert_not duplicate_menu.valid?
    assert_includes duplicate_menu.errors[:name], "has already been taken"
  end

  test "should allow same name across different restaurants" do
    create(:menu, name: "Breakfast")
    menu = build(:menu, name: "Breakfast")
    assert menu.valid?
  end

  test "should accept nested attributes for menu_items" do
    menu = build(:menu, menu_items_attributes: [
      { name: "Burger", price: 9.99 },
      { name: "Salad", price: 7.50 }
    ])
    assert menu.valid?
  end

  test "should validate associated menu_items" do
    menu = build(:menu, menu_items_attributes: [
      { name: nil, price: 9.99 } # Invalid item
    ])
    assert_not menu.valid?
    assert_includes menu.errors[:menu_items], "is invalid"
  end

  test "should have many menu_items" do
    menu = create(:menu)
    assert_equal 5, menu.menu_items.count # From factory
  end

  test "should belong to restaurant" do
    menu = create(:menu)
    assert menu.restaurant.present?
  end

  test "should not destroy menu_items on destroy" do
    menu = create(:menu)
    menu_item = menu.menu_items.first
    assert_no_difference("MenuItem.count") do
      menu.destroy
    end
  end

  test "should accept optional description" do
    menu = build(:menu, description: nil)
    assert menu.valid?
  end
end
