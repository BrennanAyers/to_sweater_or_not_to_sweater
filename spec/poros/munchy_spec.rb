#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Munchy do
  it 'is a basic object' do
    info = File.read('./spec/fixtures/munchy_info.json')
    munchy = Munchy.new(JSON.parse(info, symbolize_names: true))

    expect(munchy).to be_a Munchy
    expect(munchy.name).to eq("Kan's Kitchen")
    expect(munchy.address).to eq('1620 S Prairie Ave, Pueblo, CO 81005')
    expect(munchy.id).to eq('M4MwxQAA58B7ENV8ootI-w')
  end
end
