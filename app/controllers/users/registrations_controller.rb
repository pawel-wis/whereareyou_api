# frozen_string_literal: true

module Users
  # Registration controller to handle users reg requests
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed
    end

    def register_success
      render json: {
        message: 'Singed up sucessfilly.',
        user: current_user
      }, status: :ok
    end

    def register_failed
      render json: {
        message: 'Singing up went wrong.'
      }, status: :unprocessable_entity
    end
  end
end
