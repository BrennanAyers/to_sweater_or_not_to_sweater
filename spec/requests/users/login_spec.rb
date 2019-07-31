# frozen_string_literal: true

require 'rails_helper'

describe 'Users Login API' do
  it 'can create a session' do
    User.create!(email: 'test@test.com', password: 'password')
    post api_v1_sessions_path, params: { email: 'test@test.com', password: 'password' }

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:api_key]).to_not eq(nil)
  end

  it 'can not create a session with an incorrect password' do
    User.create!(email: 'test@test.com', password: 'password')
    post api_v1_sessions_path, params: { email: 'test@test.com', password: 'failure' }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:api_key]).to eq(nil)
    expect(result[:errors][:account]).to eq(['does not match'])
  end
end
