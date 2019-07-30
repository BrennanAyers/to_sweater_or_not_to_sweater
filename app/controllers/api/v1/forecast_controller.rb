# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a forecast request, process it, and return JSON
    class ForecastController < ApplicationController
      def show
        generated_forecast =  ForecastGenerator.new(params[:location])
        render json: ForecastSerializer.new(generated_forecast)
      end
    end
  end
end
