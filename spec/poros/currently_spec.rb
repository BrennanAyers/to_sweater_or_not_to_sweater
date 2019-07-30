# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Currently do
  before :each do
    full_forecast = JSON.parse(File.read('./spec/fixtures/currently.json'), symbolize_names: true)
    daily_forecast = JSON.parse(File.read('./spec/fixtures/single_daily.json'), symbolize_names: true)
    @currently = Currently.new(full_forecast, daily_forecast)
  end

  it 'has attributes' do
    expect(@currently.summary).to eq('Mostly Cloudy')
    expect(@currently.icon).to eq('partly-cloudy-day')
    expect(@currently.precip_probability).to eq(0.01)
    expect(@currently.precip_type).to eq('rain')
    expect(@currently.temperature).to eq(87.98)
    expect(@currently.apparent_temperature).to eq(87.98)
    expect(@currently.humidity).to eq(0.25)
    expect(@currently.uv_index).to eq("6 (high)")
    expect(@currently.visibility).to eq(3.65)
    expect(@currently.temperature_high).to eq(95.21)
    expect(@currently.temperature_low).to eq(68.15)
  end
end
