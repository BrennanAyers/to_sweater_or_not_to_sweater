# frozen_string_literal: true

# A plain ol' Ruby object to render restaurants in the Munchies endpoint
class Munchy
  attr_reader :name, :address
  
  def initialize(restaurant)
    @name = restaurant[:name]
    @address = restaurant[:location][:display_address].join(', ')
  end
end
