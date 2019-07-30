# frozen_string_literal: true

# An object to take in forecast and geocode information and create POROs to be
# serialized for the Forecast endpoint
class ForecastGenerator
  attr_reader :id, :timezone, :location

  def initialize(location)
    geocode = google_maps_service.geocode(location)[:results][0]
    lat = geocode[:geometry][:location][:lat]
    long = geocode[:geometry][:location][:lng]
    @forecast = dark_sky_service.forecast([lat, long])
    @id = Time.now.to_i
    @timezone = @forecast[:timezone]
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

  private

  def google_maps_service
    @_google_maps_service ||= GoogleMapsService.new
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
