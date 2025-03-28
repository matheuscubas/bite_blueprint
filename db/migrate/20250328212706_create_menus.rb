class CreateMenus < ActiveRecord::Migration[8.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :menus, :name, unique: true
  end
end
