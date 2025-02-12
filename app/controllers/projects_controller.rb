class ProjectsController < ApplicationController
  before_action :redirect_to_last_project, only: :index

  def index; end

  def show
    @project = Project.find(params[:id])
    # To keep it simple we are not including pagination here.
    @history_entries = @project.history_entries.order(created_at: :asc)
  end

  private

  # To keep it simple, we only allow access to the last project.
  def redirect_to_last_project
    redirect_to project_path(Project.last)
  end
end
