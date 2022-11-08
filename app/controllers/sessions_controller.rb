class SessionsController < Devise::SessionsController

    private
    def respond_with(resource, _opts = {})
        render json: { message: 'Logged OK!', user: current_user }, status: :ok
    end

    def respond_to_on_destroy
        if current_user
            render json: { message: 'Logged out OK!' }, status: :ok
        else
            render json: { message: 'Logged out FAIL!' }, status: :unauthorized
        end
    end
end
