class Menu < ApplicationRecord
  # associations
  belongs_to :restaurant
  has_and_belongs_to_many :menu_items

  # validations
  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false, scope: :restaurant_id

  # nested_attributes
  validates_associated :menu_items
  accepts_nested_attributes_for :menu_items
end
