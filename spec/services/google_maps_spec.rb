# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleMapsService do
  it '#geocode' do
    geocode = subject.geocode('denver, co')

    expect(geocode).to be_a Hash
    expect(geocode[:results]).to be_an Array
    expect(geocode[:results].first).to have_key :geometry
    expect(geocode[:results].first[:geometry]).to have_key :location
    expect(geocode[:results].first[:geometry][:location]).to have_key :lat
    expect(geocode[:results].first[:geometry][:location]).to have_key :lng
  end
end
