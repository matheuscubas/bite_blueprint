# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new.call(*args, &block)
  end
end
