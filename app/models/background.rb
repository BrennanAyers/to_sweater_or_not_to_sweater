# frozen_string_literal: true

# A PORO to store Unsplash photo information to be rendered for a background
class Background
  attr_reader :description, :url, :source

  def initialize(info)
    @description = info[:alt_description]
    @url = info[:urls][:full]
    @source = info[:links][:html]
  end
end
