# frozen_string_literal: true

require 'rails_helper'

describe 'Road Trip API' do
  it 'should return a forecast for the destination location, after adding travel time' do
    VCR.turn_off!
    user = User.create!(email: 'test@test.com', password: 'password')
    get api_v1_road_trip_path, params: { origin: 'Denver,CO', destination: 'Pueblo,CO', api_key: user.api_key }

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast[:id]).to eq((Time.now.to_i + 6413).to_s)
    expect(forecast[:type]).to eq('road_trip')
    expect(forecast[:attributes][:timezone]).to eq('America/Denver')
    expect(forecast[:attributes][:location]).to eq('Pueblo, CO, USA')
    expect(forecast[:attributes][:estimated_travel_time]).to eq('1 hour 47 minutes')

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
    expect(daily.count).to eq(1)
    expect(daily.first).to have_key(:time)
    expect(daily.first).to have_key(:icon)
    expect(daily.first).to have_key(:precip_probability)
    expect(daily.first).to have_key(:precip_type)
    expect(daily.first).to have_key(:temperature_high)
    expect(daily.first).to have_key(:temperature_low)

  end
end
