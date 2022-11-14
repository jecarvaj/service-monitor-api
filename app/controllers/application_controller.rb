class ApplicationController < ActionController::API
  # before_action :authenticate_user!, except: [:check_api] LO COMENTO POR PROBLEMAS CON LA MASTER.KEY DE RAILS PARA LA DEMO
  respond_to :json

  def check_api
    user = user_from_token
    if user
      render json: { status: 'ok', logged: 'yes' }
    else
      render json: { status: 'ok', logged: 'no' }
    end
  end

  private

  def user_from_token
    return nil if request.headers['Authorization'].nil?

    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.jwt_secret).first
    User.find(jwt_payload['sub'])
  end
end
