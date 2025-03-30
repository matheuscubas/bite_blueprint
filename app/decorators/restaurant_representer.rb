# frozen_string_literal: true

class RestaurantRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :description
  property :category
  collection :menus, decorator: MenuRepresenter
  property :created_at, exec_context: :decorator
  property :updated_at, exec_context: :decorator

  def created_at
    represented.created_at.strftime("%Y-%m-%d")
  end

  def updated_at
    represented.updated_at.strftime("%Y-%m-%d")
  end
end
