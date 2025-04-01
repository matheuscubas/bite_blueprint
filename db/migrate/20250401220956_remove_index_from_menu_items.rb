class RemoveIndexFromMenuItems < ActiveRecord::Migration[8.0]
  def change
    remove_index :menu_items, name: "index_menu_items_on_name"
  end
end
