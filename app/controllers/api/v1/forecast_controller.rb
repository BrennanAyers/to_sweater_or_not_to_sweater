# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a forecast request, process it, and return JSON
    class ForecastController < ApplicationController
      def show
        google_maps_service.geocode(params[:location])
        render json: ForecastSerializer.new
      end

      private

      def google_maps_service
        @_google_maps_service = GoogleMapsService.new
      end
    end
  end
end
