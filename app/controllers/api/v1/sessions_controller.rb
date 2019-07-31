# frozen_string_literal: true

module Api
  module V1
    # A controller to create a session for a user, and return an API key
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          render json: { api_key: user.api_key }
        else
          render json: { errors: { account: ['does not match'] } }, status: 401
        end
      end
    end
  end
end
