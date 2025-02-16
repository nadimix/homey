require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:client) { create(:client) }
  let!(:project) { create(:project, client: client) }

  before do
    session = client.sessions.create!
    Current.session = session
    request = ActionDispatch::Request.new(Rails.application.env_config)
    cookies = request.cookie_jar
    cookies.signed[:session_id] = { value: session.id, httponly: true, same_site: :lax }
  end

  describe "GET /index" do
    it "redirects to the last project" do
      get projects_path
      expect(response).to redirect_to(project_path(Project.last))
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get project_path(project)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid client_id" do
      it "creates a new project and redirects" do
        expect {
          post projects_path, params: { client_id: client.id }
        }.to change(Project, :count).by(1)

        expect(response).to redirect_to(Project.last)
        follow_redirect!
        expect(response.body).to include("Project created successfully.")
      end
    end

    context "with invalid client_id" do
      it "does not create a new project" do
        expect {
          post projects_path, params: { client_id: 9999 }
        }.to_not change(Project, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /update_status" do
    it "updates the project status" do
      post update_status_project_path(project), params: { option: "shortlisted" }
      expect(response).to have_http_status(:no_content)
      expect(project.reload.status).to eq("shortlisted")
    end
  end

  describe "POST /create_comment" do
    it "adds a comment to the project" do
      expect {
        post create_comment_project_path(project), params: { body: "New Comment" }
      }.to change { project.history_entries.count }.by(1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe "SQL Injection attempts" do
    it "prevents SQL injection on project lookup" do
      get project_path("1 OR 1=1")
      expect(response).to have_http_status(:not_found)
    end

    it "prevents SQL injection on update_status" do
      expect {
        patch update_status_project_path(project), params: { option: "completed; DROP TABLE projects;" }
      }.to_not change { Project.count }
    end
  end
end
