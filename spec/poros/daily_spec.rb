require 'rails_helper'

RSpec.describe Daily do
  before :each do
    forecast = JSON.parse(File.read('./spec/fixtures/single_daily.json'), symbolize_names: true)
    @daily = Daily.new(forecast)
  end

  it 'has attributes' do
    expect(@daily.time).to eq(1564466400)
    expect(@daily.icon).to eq('partly-cloudy-day')
    expect(@daily.precip_probability).to eq(0.06)
    expect(@daily.precip_type).to eq('rain')
    expect(@daily.temperature_high).to eq(95.21)
    expect(@daily.temperature_low).to eq(68.15)
  end
end
