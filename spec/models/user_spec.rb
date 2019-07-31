# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should have_secure_password }
    it { should validate_presence_of :password }

    it 'api_key' do
      user = User.new(email: 'api@key.com', password_digest: 'test')
      expect(user.api_key).to eq(nil)
      user.save!
      expect(user.api_key).to_not eq(nil)
    end
  end
end
