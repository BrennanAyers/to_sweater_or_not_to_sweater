# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a munchies request and return restaurants at the
    # end location based on travel time
    class MunchiesController < ApplicationController
      def index
        directions = google_maps_service.directions(params[:start], params[:end])
        require "pry"; binding.pry
      end

      private

      def google_maps_service
        @_google_maps_service ||= GoogleMapsService.new
      end
    end
  end
end
