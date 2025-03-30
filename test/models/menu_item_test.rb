require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "Cannot create a MenuItem with the same name twice" do
    menu_item_1 = create(:menu_item)
    menu_item_2 = build(:menu_item, name: menu_item_1.name)

    assert_raises(ActiveRecord::RecordNotUnique) do
      menu_item_2.save
    end
  end

  test "A MenuItem has many Menus" do
    menu_item = create(:menu_item)

    assert menu_item.menus
  end
end
