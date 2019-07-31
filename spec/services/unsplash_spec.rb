# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnsplashService do
  it '#search' do
    VCR.use_cassette('unsplash_search') do
      @search = subject.search('denver, co')
    end

    expect(@search).to be_a Hash
    expect(@search[:results]).to be_an Array
    expect(@search[:results].first).to have_key :alt_description
    expect(@search[:results].first).to have_key :urls
    expect(@search[:results].first[:urls]).to have_key :full
  end
end
