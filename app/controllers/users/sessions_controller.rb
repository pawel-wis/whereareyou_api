# frozen_string_literal: true

module Users
  # Session controller to handle session requests
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(current_user, _opts = {})
      render json: {
        message: 'You are logged in.',
        user: current_user
      }, status: :ok
    end

    def respond_to_on_destroy
      token = request.headers['authorization']
      if token.present?
        jwt_payload = JWT.decode(token.split.last,
                                 Rails.application.credentials.devise[:jwt_devise_secret])
        current_user = User.find(jwt_payload[0]['sub'])

      end
      destroy_success && return if current_user

      destroy_failed
    end

    def destroy_success
      render json: {
        message: 'You are logged out'
      }, status: :ok
    end

    def destroy_failed
      render json: {
        message: "Can't find active session"
      }, status: :unauthorized
    end
  end
end
