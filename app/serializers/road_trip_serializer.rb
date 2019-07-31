# frozen_string_literal: true

# A serializer for processing a RoadTrip object into a JSON response
class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  attributes :location, :timezone, :estimated_travel_time, :currently, :hourly, :daily
end
