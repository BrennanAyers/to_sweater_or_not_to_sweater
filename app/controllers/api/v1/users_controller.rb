# frozen_string_literal: true

module Api
  module V1
    # A controller to create users in our Database
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render json: { api_key: user.api_key }
        else
          render json: { errors: user.errors.messages }
        end
      end

      private

      def user_params
        {
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        }
      end
    end
  end
end
