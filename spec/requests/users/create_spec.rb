# frozen_string_literal: true

require 'rails_helper'

describe 'Users Create API' do
  it 'can create a user' do
    post api_v1_users_path, params: { 'email': 'test@test.com', 'password': 'password', 'password_confirmation': 'password'}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:api_key]).to_not be nil
  end
end
