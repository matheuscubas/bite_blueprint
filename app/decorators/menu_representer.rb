# frozen_string_literal: true

class MenuRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :description
  property :restaurant_id
  property :created_at, exec_context: :decorator
  property :updated_at, exec_context: :decorator
  collection :menu_items, decorator: MenuItemRepresenter

  def created_at
    represented.created_at.strftime("%Y-%m-%d")
  end

  def updated_at
    represented.updated_at.strftime("%Y-%m-%d")
  end
end
