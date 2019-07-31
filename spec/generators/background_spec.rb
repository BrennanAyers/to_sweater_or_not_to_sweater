# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BackgroundGenerator do

  it 'has an id and an image' do
    VCR.use_cassette('unsplash_search') do
      @subject = BackgroundGenerator.new('denver, co')
    end

    expect(@subject.id).to eq('denver, co background image')
    expect(@subject.image).to be_a Background
  end
end
