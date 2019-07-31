# frozen_string_literal: true

# A model to store a user of the site, and attaching access to an API Key
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_secure_password

  before_create :set_api_key

  private

  def set_api_key
    self.api_key = SecureRandom.urlsafe_base64.to_s
  end
end
