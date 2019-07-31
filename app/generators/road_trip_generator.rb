# frozen_string_literal: true

# An object to take in forecast and directions information and create POROs to
# be serialized for the RoadTrip endpoint
class RoadTripGenerator
  attr_reader :id, :timezone, :location, :estimated_travel_time

  def initialize(origin, destination)
    time_traveled = duration(origin, destination)
    @forecast = forecast_request(destination, time_traveled)
    @id = Time.now.to_i + time_traveled
    @timezone = @forecast[:timezone]
    @location = destination_geocode(destination)[:formatted_address]
    @estimated_travel_time = directions(origin, destination)[0][:legs][0][:duration][:text]
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
    Daily.new(@forecast[:daily][:data][0])
  end

  private

  def destination_geocode(destination)
    Rails.cache.fetch("geocode-#{destination}", expires_in: 24.hours) do
      google_maps_service.geocode(destination)[:results][0]
    end
  end

  def lat(destination)
    destination_geocode(destination)[:geometry][:location][:lat]
  end

  def long(destination)
    destination_geocode(destination)[:geometry][:location][:lng]
  end

  def directions(origin, destination)
    Rails.cache.fetch("directions-#{origin}-#{destination}", expires_in: 24.hours) do
      google_maps_service.directions(origin, destination)[:routes]
    end
  end

  def duration(origin, destination)
    directions(origin, destination)[0][:legs][0][:duration][:value]
  end

  def forecast_request(destination, time_traveled)
    Rails.cache.fetch("road-trip-#{destination}-#{time_traveled}", expires_in: 30.minutes) do
      dark_sky_service.forecast([lat(destination), long(destination)], time_traveled)
    end
  end

  def google_maps_service
    @_google_maps_service ||= GoogleMapsService.new
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
