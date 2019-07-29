# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a munchies request and return restaurants at the
    # end location based on travel time
    class MunchiesController < ApplicationController
      def index
        directions = google_maps_service.directions(params[:start], params[:end])
        restaurants = yelp_service.businesses(params[:end], directions[:routes][0][:legs][0][:duration][:value], params[:food])
        munchies = MunchiesGenerator.new(restaurants).top_3
        render json: MunchiesSerializer.new(munchies)
      end

      private

      def google_maps_service
        @_google_maps_service ||= GoogleMapsService.new
      end

      def yelp_service
        @_yelp_service ||= YelpService.new
      end
    end
  end
end
