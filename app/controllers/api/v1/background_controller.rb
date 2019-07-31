# frozen_string_literal: true

module Api
  module V1
    # A controller to process a Background image request for a city
    class BackgroundController < ApplicationController
      def show
        generated_background = BackgroundGenerator.new(params[:location])
      end
    end
  end
end
