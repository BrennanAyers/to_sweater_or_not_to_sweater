# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoadTripGenerator do
  include ActiveSupport::Testing::TimeHelpers

  before :each do
    travel_to Time.at(1564586681)
    geocode = File.read('./spec/fixtures/road_trip_generator_geocode.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=pueblo, co&key=#{ENV['GOOGLE_MAPS_KEY']}").to_return(status: 200, body: geocode)
    directions = File.read('./spec/fixtures/road_trip_generator_directions.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?origin=denver, co&destination=pueblo, co&key=#{ENV['GOOGLE_MAPS_KEY']}").to_return(status: 200, body: directions)
    dark_sky = File.read('./spec/fixtures/road_trip_generator_dark_sky.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_KEY']}/38.2544472,-104.6091409,1564593094").to_return(status: 200, body: dark_sky)
    @subject = RoadTripGenerator.new('denver, co', 'pueblo, co')
    travel_back
  end

  it 'has attributes' do
    expect(@subject.id).to eq(1564593094)
    expect(@subject.timezone).to eq('America/Denver')
    expect(@subject.location).to eq('Pueblo, CO, USA')
    expect(@subject.estimated_travel_time).to eq('1 hour 47 mins')
  end

  it 'should have a Currently object' do
    expect(@subject.currently).to be_an Currently
  end

  it 'should have Hourly objects' do
    expect(@subject.hourly.count).to eq(24)
    expect(@subject.hourly.first).to be_a Hourly
    expect(@subject.hourly.last).to be_a Hourly
  end

  it 'should have a Daily object' do
    expect(@subject.daily).to be_a Daily
  end
end
