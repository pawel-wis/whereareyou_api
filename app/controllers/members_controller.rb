# frozen_string_literal: true

# Members conftorrel to handle all users requests
class MembersController < ApplicationController
  before_aciton :authenticate_user!

  def show
    user = return_user_from_token
    render json: {
      message: 'We got this',
      user:
    }
  end

  private

  def return_user_form_token
    jwt_payload = JWT.decode(
      request.headers['Authorization'].split[1],
      Rails.application.credentials.devise[:jwt_secret_key]
    ).first
    use_id
    jwt_payload['sub']
    User.find(user_id.to_s)
  end
end
