# frozen_string_literal: true

require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe ForecastGenerator do
  before :each do
    travel_to Time.at(1564506000)
    geocode = File.read('./spec/fixtures/forecast_generator_geocode.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver, co&key=#{ENV['GOOGLE_MAPS_KEY']}")
          .to_return(status: 200, body: geocode)
    dark_sky = File.read('./spec/fixtures/forecast_generator_dark_sky.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_KEY']}/39.7392358,-104.990251")
          .to_return(status: 200, body: dark_sky)
    @subject = ForecastGenerator.new('denver, co')
    travel_back
  end

  it 'has attributes' do
    expect(@subject.id).to eq(1564506000)
    expect(@subject.timezone).to eq('America/Denver')
    expect(@subject.location).to eq('Denver, CO, USA')
    require "pry"; binding.pry
  end

  it 'should have a Currently object' do
    expect(@subject.currently).to be_an Currently
  end

  it 'should have Hourly objects' do
    expect(@subject.hourly.count).to eq(24)
    expect(@subject.hourly.first).to be_a Hourly
    expect(@subject.hourly.last).to be_a Hourly
  end

  it 'should have Daily objects' do
    expect(@subject.daily.count).to eq(5)
    expect(@subject.daily.first).to be_a Daily
    expect(@subject.daily.last).to be_a Daily
  end

end
