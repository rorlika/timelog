require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/auth/login' do

    before do
      @user = create(:user)
    end
    post 'User login' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              password: { type: :string }
          },
          required: ['email', 'password']
      }

      response '200', 'user loged in' do
        let(:user) { { email: @user.email, password: @user.password } }
        run_test!
      end

      response '401', 'unauthorize' do
        let(:user) { nil }
        run_test!
      end
    end
  end
end