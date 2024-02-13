class Users::SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(resource, _opts={})
        render json: {
            message: 'You are logged in.',
            user: current_user
        }, status: :ok
    end

    def respond_to_on_destroy
        logout_success && current_user
        logout_failure
    end

    def logout_success
        render json: {message: 'You are logged out.'}
    end

    def logout_failure
        render json: {message: 'Logging out went wrong.'}
    end
end