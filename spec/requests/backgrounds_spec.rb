# frozen_string_literal: true

require 'rails_helper'

describe 'Background API' do
  it 'should send a background for Denver, CO' do
    get '/api/v1/background?location=denver, co'

    expect(response).to be_successful

    photo = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(photo[:type]).to eq('background')
  end
end
