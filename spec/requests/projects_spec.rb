require 'rails_helper'

RSpec.describe 'Project API', type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:project).to_json }

  describe 'Post project/create' do
    context 'when valid request' do
      before { post '/project/create', params: valid_attributes, headers: valid_headers }

      it 'create a new project' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(response.body).to include("Project created successfully")
      end
    end

    context 'when invalid request' do
      before { post '/project/create', params: {}, headers: valid_headers }

      it 'does not create a new project' do
        expect(response.body).to include("Validation failed: Name can't be blank")
      end
    end

    context 'when missing token' do
      before { post '/project/create', params: valid_attributes, headers: valid_headers.except(:Authorization) }

      it 'returns failure message' do
        expect(response.body).to include('Missing token')
      end
    end
  end

  describe 'GET /reports' do
    let!(:project) { create(:project, user_id: user.id) }
    let(:log) { create(:log, user_id: user.id, project_id: project.id) }
    context 'when valid request' do
      before do
        log
        get "/reports?project_id=#{project.id}", headers: valid_headers
      end

      it 'returns reports' do
        expect(response.body).to include('TotalHoursReported')
      end
    end

    context 'when invalid request' do
      before { get "/reports?project_id=100", headers: valid_headers}

      it 'retruns failure message' do
        expect(response.body).to include("Couldn't find Project")
      end
    end

    context 'when user do not have logs' do
      before { get "/reports?project_id=#{project.id}", headers: valid_headers }

      it 'returns failure message' do
        expect(response.body).to include('You do not have logs to generate reports')
      end
    end
  end
end