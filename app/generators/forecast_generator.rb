# frozen_string_literal: true

# An object to take in forecast and geocode information and create POROs to be
# serialized for the Forecast endpoint
class ForecastGenerator
  attr_reader :id, :timezone, :location

  def initialize(dark_sky_response, geocode)
    @forecast = dark_sky_response
    @id = Time.now.to_i
    @timezone = dark_sky_response[:timezone]
    @location = geocode[:formatted_address]
  end

  def currently
    Currently.new(@forecast[:currently], @forecast[:daily][:data][0])
  end

  def hourly
    @forecast[:hourly][:data][0..23].map do |hour|
      Hourly.new(hour)
    end
  end

  def daily
    @forecast[:daily][:data][1..5].map do |day|
      Daily.new(day)
    end
  end
end
