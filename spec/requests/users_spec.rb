require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:headers) { { 'Content-Type': 'application/json' } }
  let(:valid_attributes) { attributes_for(:user).to_json }

  # User signup test suite
  describe 'Post /signup' do
    context 'when valid request' do
      before { post '/api/v1/signup', params: valid_attributes, headers: headers }

      it 'creaes a new user' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(response.body).to include("Account created successfully")
      end

      it 'returns an authentication token' do
        expect(['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/api/v1/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(response.body).to include "Validation failed:"
      end
    end
  end
end