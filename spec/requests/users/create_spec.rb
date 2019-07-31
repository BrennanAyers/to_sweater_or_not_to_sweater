# frozen_string_literal: true

require 'rails_helper'

describe 'Users Create API' do
  it 'can create a user' do
    post api_v1_users_path, params: { 'email': 'test@test.com', 'password': 'password', 'password_confirmation': 'password'}

    expect(response).to be_successful
    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:api_key]).to_not eq(nil)
  end

  it 'can not create a user with an existing email' do
    User.create!(email: 'test@test.com', password_digest: 'failure')
    post api_v1_users_path, params: { 'email': 'test@test.com', 'password': 'password', 'password_confirmation': 'password'}

    expect(response).to_not be_successful
    expect(response.status).to eq(409)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:api_key]).to eq(nil)
    expect(result[:errors][:email]).to eq(['has already been taken'])
  end
end
