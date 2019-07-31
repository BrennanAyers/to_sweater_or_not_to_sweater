# frozen_string_literal: true

module Api
  module V1
    # A controller to create users in our Database
    class UsersController < ApplicationController
      def create
        user = User.create({ email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation] })
        render json: { 'test': 'test' }
      end
    end
  end
end
