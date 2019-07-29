# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MunchiesGenerator do
  json = File.read('./spec/fixtures/munchies_generator.json')
  subject = MunchiesGenerator.new(JSON.parse(json, symbolize_names: true))
  it 'generates Munchies' do

    expect(subject.top_3.count).to eq(3)
    expect(subject.top_3.first).to be_a Munchy
    expect(subject.top_3.last).to be_a Munchy
  end
end
