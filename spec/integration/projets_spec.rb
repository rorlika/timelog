require 'swagger_helper'

describe 'Projects API' do

  path '/api/v1/project/create' do

    post 'Create a project' do
      tags 'Projects'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :project, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string }
          },
          required: [ 'name' ]
      }

      response '200', 'user created' do
        let(:user) { create(:user) }
        let(:Authorization) { "#{token_generator(user.id)}" }
        let(:project) { { name: 'user1', user_id: user.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let!(:user) { create(:user) }
        let(:Authorization) { "#{token_generator(user.id)}" }
        let!(:project) { nil }
        run_test!
      end
    end
  end

  path '/api/v1/project/report?project_id={project_id}' do
    before do
      @user = create(:user)
    end

    get 'Generate a report' do
      tags 'Reports'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :project_id, in: :path,
      schema: {
          type: :object,
          properties: {
              project_id: { type: :string }
          },
          required: [ 'project_id' ]
      }

      response '200', 'report generated' do
        let(:Authorization) { "#{token_generator(@user.id)}" }
        let!(:project) { create(:project, user_id: @user.id) }
        let(:project_id) { "#{project.id}" }
        let!(:log) { create(:log, user_id: @user.id, project_id: project.id) }
        run_test!
      end

      response '404', 'project not found' do
        let(:Authorization) { "#{token_generator(@user.id)}" }
        let(:project_id) { nil }
        run_test!
      end
    end
  end
end