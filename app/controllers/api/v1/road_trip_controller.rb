# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a road_trip request, process it, and return JSON
    class RoadTripController < ApplicationController
      def show
        user = User.find_by(api_key: params[:api_key])
        if user
          generated_forecast = RoadTripGenerator.new(params[:origin], params[:destination])
          render json: RoadTripSerializer.new(generated_forecast)
        else
          render json: { error: 'Unauthorized' }, status: 401
        end
      end
    end
  end
end
