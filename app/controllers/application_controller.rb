class ApplicationController < ActionController::API
    before_action :authenticate_user!, except: [:check_api]
    respond_to :json

    def check_api
        user = get_user_from_token
        if user
            render json: { status: 'ok', logged: 'yes' }
        else
            render json: { status: 'ok', logged: 'no' }
        end
    end

    private

    def get_user_from_token
        return if request.headers['Authorization'].nil?

        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.jwt_secret).first
        user_id = jwt_payload['sub']
        user = User.find(user_id)
    end
end
