require 'swagger_helper'

describe 'Logs API' do

  path '/api/v1/log/create' do

    post 'Create a log' do
      tags 'Logs'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :log, in: :body,
      schema: {
          type: :object,
          properties: {
              project_id: { type: :integer },
              hours: { type: :integer },
              log_date: { type: :date }
          },
          required: [ 'project_id', 'hours', 'log_date' ]
      }

      response '200', 'user created' do
        let!(:user) { create(:user) }
        let(:Authorization) { "#{token_generator(user.id)}" }
        let!(:project) { create(:project, user_id: user.id) }
        let!(:log) { create(:log, project_id: project.id, user_id: user.id) }
        run_test!
      end

      response '422', 'invalid request' do
        let!(:user) { create(:user) }
        let(:Authorization) { "#{token_generator(user.id)}" }
        let(:project_id) { nil }
        let(:log) { nil }
        run_test!
      end
    end
  end
end