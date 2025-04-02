class Restaurant < ApplicationRecord
  # relations
  has_many :menus
  has_many :menu_items, through: :menus

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # nested attributes
  validates_associated :menus
  accepts_nested_attributes_for :menus
end
