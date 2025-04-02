class MenuItem < ApplicationRecord
  # associations
  has_and_belongs_to_many :menus

  # validations
  validates_presence_of :name
  validates_numericality_of :price, greater_than: 0
  validate :unique_name_per_menu

  private

  def unique_name_per_menu
    return if menus.empty?

    menus.each do |menu|
      existing_items = menu.menu_items.where(name: name)

      if existing_items.exists?
        errors.add(:name, "A MenuItem with name = '#{name}' already exists in menu '#{menu.name}'")
      end
    end
  end
end
