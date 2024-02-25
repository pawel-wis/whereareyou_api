# frozen_string_literal: true

module Users
  # Registration controller to handle users reg requests
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed_already_exist(:username) && return if User.find_by(username: resource.username)
      register_failed_already_exist(:email) && return if User.find_by(email: resource.email)

      register_failed
    end

    def register_success
      render json: {
        message: 'Singed up sucessfully.',
        user: current_user
      }, status: :created
    end

    def register_failed
      render json: {
        message: 'Bad form requested.'
      }, status: :unprocessable_entity
    end

    def register_failed_already_exist(field)
      render json: {
        message: "User with this #{field} already exist."
      }, status: :conflict
    end

  end
end
