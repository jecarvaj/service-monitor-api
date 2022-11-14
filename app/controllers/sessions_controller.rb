class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: { message: 'Logged.', user: resource }, status: :ok
    else
      login_failure
    end
  end

  def respond_to_on_destroy
    current_user ? login_success : login_failure
  end

  def login_success
    render json: { message: 'Logg ok.' }, status: :ok
  end

  def login_failure
    render json: { message: 'Logg failure.' }, status: :unauthorized
  end
end
