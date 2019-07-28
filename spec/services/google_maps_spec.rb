# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleMapsService do
  it '#geocodes' do
      geocodes = subject.geocodes('denver, co')

      expect(geocodes).to be_a Hash
      expect(geocodes[:results]).to be_an Array
      expect(geocodes[:results].first).to have_key :geometry
      expect(geocodes[:results].first[:geometry]).to have_key :location
      expect(geocodes[:results].first[:geometry][:location]).to have_key :lat
      expect(geocodes[:results].first[:geometry][:location]).to have_key :lng
    end
end
