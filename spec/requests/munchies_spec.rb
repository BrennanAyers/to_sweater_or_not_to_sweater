# frozen_string_literal: true

require 'rails_helper'

describe 'Munchies API' do
  it 'returns 3 open restaurants in the ending city after travel' do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful

    results = JSON.parse(response.body)

    expect(results).to be_a Hash
    expect(results['meta']['destination']).to eq('Pueblo')
    expect(results['data']).to be_an Array
    expect(results['data'].count).to eq(3)
    expect(results['data'].first['attributes']).to have_key 'name'
    expect(results['data'].first['attributes']).to have_key 'address'
  end
end
