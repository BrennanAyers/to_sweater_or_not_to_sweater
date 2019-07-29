# frozen_string_literal: true

# A serializer for processing a collection of Munchy objects
class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address
end
