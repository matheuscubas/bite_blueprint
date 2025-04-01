class RemoveUniquenessConstraintFromDatabase < ActiveRecord::Migration[8.0]
  def change
    remove_index :menus, :name
  end
end
