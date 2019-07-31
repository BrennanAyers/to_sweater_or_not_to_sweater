# frozen_string_literal: true

require 'rails_helper'

describe 'Road Trip API' do
  include ActiveSupport::Testing::TimeHelpers

  it 'should return a forecast for the destination location, after adding travel time' do
    user = User.create!(email: 'test@test.com', password: 'password')
    travel_to Time.at(1564586681)
    VCR.use_cassette('road_trip_endpoint') do
      get api_v1_road_trip_path, params: { origin: 'Denver,CO', destination: 'Pueblo,CO', api_key: user.api_key }
    end
    travel_back

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast[:id]).to eq('1564593094')
    expect(forecast[:type]).to eq('road_trip')
    expect(forecast[:attributes][:timezone]).to eq('America/Denver')
    expect(forecast[:attributes][:location]).to eq('Pueblo, CO, USA')
    expect(forecast[:attributes][:estimated_travel_time]).to eq('1 hour 47 mins')

    currently = forecast[:attributes][:currently]
    expect(currently).to be_a Hash
    expect(currently).to have_key(:summary)
    expect(currently).to have_key(:icon)
    expect(currently).to have_key(:precip_probability)
    expect(currently).to have_key(:precip_type)
    expect(currently).to have_key(:temperature)
    expect(currently).to have_key(:apparent_temperature)
    expect(currently).to have_key(:humidity)
    expect(currently).to have_key(:uv_index)
    expect(currently).to have_key(:visibility)
    expect(currently).to have_key(:temperature_high)
    expect(currently).to have_key(:temperature_low)

    hourly = forecast[:attributes][:hourly]
    expect(hourly.count).to eq(24)
    expect(hourly.first).to have_key(:time)
    expect(hourly.first).to have_key(:temperature)
    expect(hourly.first).to have_key(:icon)
    expect(hourly.last).to have_key(:time)
    expect(hourly.last).to have_key(:temperature)
    expect(hourly.last).to have_key(:icon)

    daily = forecast[:attributes][:daily]
    expect(daily).to be_a Hash
    expect(daily).to have_key(:time)
    expect(daily).to have_key(:icon)
    expect(daily).to have_key(:precip_probability)
    expect(daily).to have_key(:precip_type)
    expect(daily).to have_key(:temperature_high)
    expect(daily).to have_key(:temperature_low)

  end
end
