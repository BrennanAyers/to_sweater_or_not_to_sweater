# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Background do
  before :each do
    image = JSON.parse(File.read('./spec/fixtures/image.json'), symbolize_names: true)
    @background = Background.new(image)
  end

  it 'has attributes' do
    expect(@background.description).to eq('person standing on sand dune')
    expect(@background.url).to eq('https://images.unsplash.com/photo-1553969824-a69ef8081e55?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjg0MzI0fQ')
    expect(@background.source).to eq('https://unsplash.com/photos/fw9cbA1WTi0')
  end
end
