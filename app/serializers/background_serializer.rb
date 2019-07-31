# frozen_string_literal: true

# A serializer to take in a BackgroundGenerator and return valid JSON
class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  attributes :image
end
