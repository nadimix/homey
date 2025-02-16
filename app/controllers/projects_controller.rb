class ProjectsController < ApplicationController
  before_action :redirect_to_last_project, only: :index
  before_action :ensure_project!, only: %i[show update_status create_comment]
  before_action :ensure_client!, only: %i[create]

  def index; end

  def show
    # To keep it simple we are not including pagination here.
    # To prevent N+1 queries, we include the user in the history entries.
    @history_entries = @project.history_entries.includes(:user).order(created_at: :asc)
    @statuses = Project.statuses.keys
  end

  def create
    # To keep it simple by now, we keep using the same client on all projects
    @project = Project.new(client: @client)
    if @project.save
      flash[:notice] = "Project created successfully."
      redirect_to @project
    else
      flash[:alert] = "There was an error creating the project. Please try again."
      redirect_back(fallback_location: root_path)
    end
  end

  def update_status
    @project.update(status: params[:option])
    new_entry = @project.history_entries.status_change.new(
      body: params[:option],
      user: Current.user
    )

    if new_entry.save
      flash[:notice] = "Project status updated successfully."
      render json: {}, status: :no_content
    else
      flash[:alert] = "There was an error updating the project. Please try again."
      redirect_back(fallback_location: root_path)
    end
  end

  def create_comment
    new_entry = @project.history_entries.comment.new(
      body: params[:body],
      user: Current.user
    )

    if new_entry.save
      flash[:notice] = "Comment added successfully."
      render json: {}, status: :no_content
    else
      flash[:alert] = "There was an error updating the project. Please try again."
      redirect_back(fallback_location: root_path)
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
