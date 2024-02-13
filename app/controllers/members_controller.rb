class MembersController < ApplicationController
   before_acion: :authenticate_user! 

   def show
    user = get_user_from_token
    render json: {
        message: "We got this",
        user: user
    }
    end

    private
    def get_user_form_token
        jwt_payload = JWT.decode(
            request.headers['Authorization'].split(' ')[1],
            Rails.application.credentials.devise[:jwt_secret_key]
        ).first
        use_id - jwt_payload['sub']
        user = User.find(user_id.to_s)
    end
end