module Api
  module V1
    class LogsController < ApplicationController
      def create
        Log.create!(log_params.merge(user_id: current_user.id))
        response = { message: Message.log_created }
        render json: response
      end

      private

      def log_params
        params.permit(:project_id, :hours, :log_date)
      end
    end
  end
end