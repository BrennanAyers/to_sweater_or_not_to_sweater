# frozen_string_literal: true

module Api
  module V1
    # A controller to take in a forecast request, process it, and return JSON
    class ForecastController < ApplicationController
      def show
        render json: ForecastSerializer.new
      end
    end
  end
end
