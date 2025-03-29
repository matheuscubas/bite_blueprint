require "test_helper"

class MenuTest < ActiveSupport::TestCase
  test "A Menu can have many MenuItem" do
    menu = create(:menu)

    assert menu.menu_items.size > 1
  end

  test "Cannot create Menus with the same name" do
    menu_1 = create(:menu)
    menu_2 = build(:menu, name: menu_1.name)

    assert_raises(ActiveRecord::RecordNotUnique) do
      menu_2.save
    end
  end
end
