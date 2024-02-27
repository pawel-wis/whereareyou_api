# frozen_string_literal: true

module Users
  # Registration controller to handle users reg requests
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(user, _opts = {})
      register_success && return if user.persisted?

      if !match_password?(user)
        return register_failed
      elsif User.find_by(username: user.username)
        return register_failed_already_exist(:username)
      elsif User.find_by(email: user.email)
        return register_failed_already_exist(:email)
      end

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

    def match_password?(user)
      user.password == user.password_confirmation
    end
  end
end
