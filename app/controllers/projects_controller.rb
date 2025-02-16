class ProjectsController < ApplicationController
  before_action :redirect_to_last_project, only: :index
  before_action :ensure_project!, only: %i[show update_status create_comment]
  before_action :ensure_client!, only: %i[create]

  def index; end

  def show
    # To keep it simple we are not including pagination here.
    @history_entries = @project.history_entries.order(created_at: :asc)
    # TODO: Rework to only show options depending on the current user's role and the project's status
    @statuses = Project.statuses.keys
  end

  def create
    # To keep it simple by now, we keep using the same client on all projects
    @project = Project.create!(client: @client)
    redirect_to @project
  end

  def update_status
    @project.update(status: params[:option])
    @project.history_entries.status_change.create(body: params[:option], user: Current.user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @project }
    end
  end

  def create_comment
    @project.history_entries.comment.create(body: params[:comment], user: Current.user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @project }
    end
  end

  private

  # To keep it simple, we only allow access to the last project.
  def redirect_to_last_project
    redirect_to project_path(Project.last)
  end

  def ensure_project!
    @project = Project.find(params[:id])
  end

  def ensure_client!
    @client = Client.find(params[:client_id])
  end
end
