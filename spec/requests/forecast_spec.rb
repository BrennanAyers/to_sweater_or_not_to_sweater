# frozen_string_literal: true

require 'rails_helper'

describe 'Forecast API' do
  before :each do
  end

  it 'sends the weather for Denver' do
    get '/api/v1/forecast?location=denver, co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast[:id]).to eq(Time.now.to_i.to_s)
    expect(forecast[:type]).to eq('forecast')
    expect(forecast[:attributes][:timezone]).to eq('America/Denver')
    expect(forecast[:attributes][:location]).to eq('Denver, CO, USA')

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
    expect(daily.count).to eq(5)
    expect(daily.first).to have_key(:time)
    expect(daily.first).to have_key(:icon)
    expect(daily.first).to have_key(:precip_probability)
    expect(daily.first).to have_key(:precip_type)
    expect(daily.first).to have_key(:temperature_high)
    expect(daily.first).to have_key(:temperature_low)
  end
end
