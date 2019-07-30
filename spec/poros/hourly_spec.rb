# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hourly do
  before :each do
    forecast = JSON.parse(File.read('./spec/fixtures/single_hourly.json'), symbolize_names: true)
    @hourly = Hourly.new(forecast)
  end

  it 'has attributes' do
    expect(@hourly.time).to eq(1564466400)
    expect(@hourly.icon).to eq('clear-night')
    expect(@hourly.temperature).to eq(73.85)
  end
end
