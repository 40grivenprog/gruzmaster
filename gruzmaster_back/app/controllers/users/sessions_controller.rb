class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: { token: current_token, user_id: current_user.id, is_admin: current_user.is_admin?, message: 'You are logged in.' }, status: :ok
    else
      render json: { messages: ["Invalid login or password"] }, status: 500
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
