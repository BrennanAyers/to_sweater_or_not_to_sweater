# frozen_string_literal: true

# A serializer for processing a Forecast object into a JSON response
class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :location, :timezone, :currently, :hourly, :daily
end
