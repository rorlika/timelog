require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/signup' do

    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: [ 'name', 'email', 'password', 'password_confirmation' ]
      }

      response '200', 'user created' do
        let(:user) { { name: 'testuser', email: 'testuser@gmail.com', password: '1234', password_confirmation: '1234' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { nil }
        run_test!
      end
    end
  end
end