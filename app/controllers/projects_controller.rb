class ProjectsController < ApplicationController
  def create
    Project.create!(name: params[:name], user_id: current_user.id)
    response = { message: Message.project_created }
    render json: response
  end

  def reports
    project = Project.find_by!(id: params[:project_id], user_id: current_user.id)
    render json: generate_reports(project)
  rescue ActiveRecord::RecordNotFound
    raise(ActiveRecord::RecordInvalid, ("#{Message.invalid_token}"))
  end

  private

  def generate_reports(project)
    logs = Log.where(user_id: current_user.id, project_id: project.id)
    return { message: 'You do not have logs to generate reports' } if logs.empty?
    total_hours = logs.sum(:hours)
    first_date, last_date = logs.pluck(:log_date).minmax

    reports = {
        TotalHoursReported: total_hours,
        FirstReportDate: first_date,
        LastReportDate: last_date
    }

    { "#{project.name}": reports }
  end
end
