# frozen_string_literal: true

class MenuItemRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :description
  property :price, exec_context: :decorator
  property :created_at, exec_context: :decorator
  property :updated_at, exec_context: :decorator

  def price
    represented.price / 100.0
  end

  def created_at
    represented.created_at.strftime("%Y-%m-%d")
  end

  def updated_at
    represented.updated_at.strftime("%Y-%m-%d")
  end
end
