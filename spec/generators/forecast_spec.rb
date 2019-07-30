# frozen_string_literal: true

require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe ForecastGenerator do
  travel_to Time.at(1564506000)
  dark_sky = JSON.parse(File.read('./spec/fixtures/forecast_generator_dark_sky.json'), symbolize_names: true)
  geocode = JSON.parse(File.read('./spec/fixtures/forecast_generator_geocode.json'), symbolize_names: true)[:results][0]
  subject = ForecastGenerator.new(dark_sky, geocode)
  travel_back

  it 'has attributes' do
    expect(subject.id).to eq(1564506000)
    expect(subject.timezone).to eq('America/Denver')
    expect(subject.location).to eq('Denver, CO, USA')
  end

  it 'should have a Currently object' do
    expect(subject.currently).to be_an Currently
  end

  it 'should have Hourly objects' do
    expect(subject.hourly.count).to eq(24)
    expect(subject.hourly.first).to be_a Hourly
    expect(subject.hourly.last).to be_a Hourly
  end

  it 'should have Daily objects' do
    expect(subject.daily.count).to eq(5)
    expect(subject.daily.first).to be_a Daily
    expect(subject.daily.last).to be_a Daily
  end

end
