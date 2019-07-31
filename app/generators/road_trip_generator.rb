# frozen_string_literal: true

# An object to take in forecast and directions information and create POROs to
# be serialized for the RoadTrip endpoint
class RoadTripGenerator
  attr_reader :id, :timezone, :location, :estimated_travel_time

  def initialize(origin, destination)
    destination_geocode = google_maps_service.geocode(destination)[:results][0]
    lat = destination_geocode[:geometry][:location][:lat]
    long = destination_geocode[:geometry][:location][:lng]
    directions = google_maps_service.directions(origin, destination)[:routes]
    duration = directions[0][:legs][0][:duration][:value]
    @forecast = dark_sky_service.forecast([lat, long], duration)
    @id = Time.now.to_i + duration
    @timezone = @forecast[:timezone]
    @location = destination_geocode[:formatted_address]
    @estimated_travel_time = directions[0][:legs][0][:duration][:text]
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

  def google_maps_service
    @_google_maps_service ||= GoogleMapsService.new
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
