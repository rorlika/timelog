module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class ExpiredSignature < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::ExpiredSignature, with: :invalid_token
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def unprocessable(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 498 - invalid token
  def invalid_token(e)
    render json: { message: e.message }, status: :invalid_token
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end