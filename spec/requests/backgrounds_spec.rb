# frozen_string_literal: true

require 'rails_helper'

describe 'Background API' do
  it 'should send a background for Denver, CO' do
    VCR.use_cassette('background_endpoint') do
      get '/api/v1/background?location=denver, co'
    end

    expect(response).to be_successful

    photo = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(photo[:id]).to eq('denver, co background image')
    expect(photo[:type]).to eq('background')
    expect(photo[:attributes][:image]).to have_key(:description)
    expect(photo[:attributes][:image]).to have_key(:url)
    expect(photo[:attributes][:image]).to have_key(:source)
  end
end
