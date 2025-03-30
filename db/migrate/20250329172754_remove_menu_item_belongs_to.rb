class RemoveMenuItemBelongsTo < ActiveRecord::Migration[8.0]
  def change
    remove_belongs_to :menu_items, :menu
  end
end
