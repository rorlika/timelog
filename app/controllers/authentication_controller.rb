class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return access token
  def authenticate
    access_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    render json: { access_token: access_token }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end