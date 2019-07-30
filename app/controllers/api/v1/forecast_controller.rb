# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a forecast request, process it, and return JSON
    class ForecastController < ApplicationController
      def show
        geocode = google_maps_service.geocode(params[:location])[:results][0]
        lat = geocode[:geometry][:location][:lat]
        long = geocode[:geometry][:location][:lng]
        forecast = dark_sky_service.forecast([lat, long])
        generated_forecast =  ForecastGenerator.new(forecast, geocode)
        render json: ForecastSerializer.new(generated_forecast)
      end

      private

      def google_maps_service
        @_google_maps_service ||= GoogleMapsService.new
      end

      def dark_sky_service
        @_dark_sky_service ||= DarkSkyService.new
      end
    end
  end
end
