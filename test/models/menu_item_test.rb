require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "Cannot create a MenuItem with the same name twice" do
    menu_item_1 = create(:menu_item)
    menu_item_2 = build(:menu_item, name: menu_item_1.name)

    assert_raises(ActiveRecord::RecordNotUnique) do
      menu_item_2.save
    end
  end

  test "Cannot create a MenuItem without a Menu" do
    menu_item = build(:menu_item, menu: nil)

    assert_not menu_item.save
  end

  test "A MenuItem belongs to a Menu" do
    menu_item = create(:menu_item)

    assert menu_item.menu
  end
end
