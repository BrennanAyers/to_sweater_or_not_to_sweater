# frozen_string_literal: true

# A generator to make Munchies objects
class MunchiesGenerator
  def initialize(restaurants)
    @restaurants = restaurants
  end

  def top_3
    @restaurants[:businesses].take(3).map do |restaurant|
      Munchy.new(restaurant)
    end
  end
end
