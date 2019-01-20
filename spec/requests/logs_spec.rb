require 'rails_helper'

RSpec.describe 'Log API', type: :request do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let(:valid_attributes) { attributes_for(:log) }

  describe 'Post log/create' do
    context 'when valid request' do
      before do
        post '/api/v1/log/create', params: valid_attributes.merge(project_id: project.id).to_json, headers: valid_headers
      end

      it 'create a new log' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(response.body).to include("Log created successfully")
      end
    end

    context 'when invalid request' do
      before { post '/api/v1/log/create', params: {}, headers: valid_headers }

      it 'does not create a new log' do
        expect(response.body).to include("Validation failed:")
      end
    end

    context 'when missing token' do
      before { post '/api/v1/log/create', params: valid_attributes.to_json, headers: valid_headers.except(:Authorization) }

      it 'returns failure message' do
        expect(response.body).to include('Missing token')
      end
    end
  end
end