# frozen_string_literal: true

require 'rails_helper'

describe 'Forecast API' do
  before :each do
  end

  it 'sends the weather for Denver' do
    get '/api/v1/forecast?location=denver, co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body)

    expect(forecast['currently']['temperature']).to eq('86')
  end
end
