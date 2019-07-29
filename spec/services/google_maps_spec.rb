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

  it '#directions' do
    directions = subject.directions('denver, co', 'pueblo, co')

    expect(directions).to be_a Hash
    expect(directions[:routes]).to be_an Array
    expect(directions[:routes].first).to have_key :legs
    expect(directions[:routes].first[:legs]).to be_an Array
    expect(directions[:routes].first[:legs].first).to have_key :duration
    expect(directions[:routes].first[:legs].first[:duration]).to have_key :value
    expect(directions[:routes].first[:legs].first[:duration][:value]).to be_an Integer
  end
end
