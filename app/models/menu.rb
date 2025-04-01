class Menu < ApplicationRecord
  belongs_to :restaurant

  has_and_belongs_to_many :menu_items
  validates_associated :menu_items

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false, scope: :restaurant_id
end
