# frozen_string_literal

require 'rails_helper'

RSpec.describe YelpService do
  it '#businesses' do
    results = subject.businesses('pueblo, co', 6413, 'chinese')

    expect(results).to be_a Hash
    expect(results[:businesses]).to be_an Array
    expect(results[:businesses].first).to have_key :name
    expect(results[:businesses].first).to have_key :location
    expect(results[:businesses].first[:location]).to have_key :display_address
    expect(results[:businesses].first[:location][:display_address]).to be_an Array
  end
end
