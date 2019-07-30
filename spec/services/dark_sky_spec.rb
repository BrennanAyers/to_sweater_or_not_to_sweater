# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DarkSkyService do
  it 'forecast' do
    VCR.use_cassette('dark_sky_forecast') do
      @forecast = subject.forecast([39.7392358, -104.990251])
    end

    expect(@forecast).to be_a Hash
    expect(@forecast[:currently]).to be_a Hash
    expect(@forecast[:currently]).to have_key :summary
    expect(@forecast[:currently]).to have_key :icon
    expect(@forecast[:currently]).to have_key :precipProbability
    # expect(@forecast[:currently]).to have_key :precipType
    expect(@forecast[:currently]).to have_key :time
    expect(@forecast[:currently]).to have_key :temperature
    expect(@forecast[:currently]).to have_key :apparentTemperature
    expect(@forecast[:currently]).to have_key :humidity
    expect(@forecast[:currently]).to have_key :visibility
    expect(@forecast[:currently]).to have_key :ozone

    expect(@forecast[:hourly]).to be_a Hash
    expect(@forecast[:hourly]).to have_key :summary
    expect(@forecast[:hourly]).to have_key :icon
    expect(@forecast[:hourly]).to have_key :data

    expect(@forecast[:daily]).to be_a Hash
    expect(@forecast[:daily]).to have_key :summary
    expect(@forecast[:daily]).to have_key :icon
    expect(@forecast[:daily]).to have_key :data
  end
end
