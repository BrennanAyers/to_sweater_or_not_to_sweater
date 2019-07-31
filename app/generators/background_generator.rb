# frozen_string_literal: true

# An object to take in a location and create a Background image PORO
class BackgroundGenerator
  attr_reader :id, :image

  def initialize(location)
    @id = "#{location} background image"
    unsplash_search = unsplash_service.search(location.split(',')[0])
    unsplash_image = unsplash_search[:results][0]
    @image = Background.new(unsplash_image)
  end

  private

  def unsplash_service
    @_unsplash_service ||= UnsplashService.new
  end
end
