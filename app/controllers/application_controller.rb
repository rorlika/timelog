class ApplicationController < ActionController::API
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  skip_before_action :authorize_request, only: :home
  attr_reader :current_user

  def home
    redirect_to '/api-docs'
  end

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end