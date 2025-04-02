# test/models/menu_item_test.rb
require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "should be valid with required attributes" do
    menu_item = build(:menu_item)
    assert menu_item.valid?
  end

  test "should require name" do
    menu_item = build(:menu_item, name: nil)
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:name], "can't be blank"
  end

  test "should require price" do
    menu_item = build(:menu_item, price: nil)
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:price], "is not a number"
  end

  test "should require price greater than 0" do
    menu_item = build(:menu_item, price: 0)
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:price], "must be greater than 0"
  end

  test "should accept negative price" do
    menu_item = build(:menu_item, price: -5.99)
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:price], "must be greater than 0"
  end

  test "should have many menus" do
    menu_item = create(:menu_item)
    create(:menu, menu_items: [ menu_item ])
    assert_equal 1, menu_item.menus.count
  end

  test "should validate unique name per menu" do
    menu = create(:menu)
    create(:menu_item, name: "Special Burger", menus: [ menu ])
    duplicate_item = build(:menu_item, name: "Special Burger", menus: [ menu ])

    assert_not duplicate_item.valid?
    assert_includes duplicate_item.errors[:name], "A MenuItem with name = 'Special Burger' already exists in menu '#{menu.name}'"
  end

  test "should allow same name across different menus" do
    menu1 = create(:menu)
    menu2 = create(:menu)
    create(:menu_item, name: "Special Burger", menus: [ menu1 ])
    item = build(:menu_item, name: "Special Burger", menus: [ menu2 ])

    assert item.valid?
  end

  test "should accept optional description" do
    menu_item = build(:menu_item, description: nil)
    assert menu_item.valid?
  end

  test "should not destroy menus when destroyed" do
    menu = create(:menu)
    menu_item = create(:menu_item, menus: [ menu ])
    assert_no_difference("Menu.count") do
      menu_item.destroy
    end
  end

  test "should clean up join table on destroy" do
    menu = create(:menu)
    menu_item = create(:menu_item, menus: [ menu ])
    assert_difference("menu.menu_items.count", -1) do
      menu_item.destroy
    end
  end
end
