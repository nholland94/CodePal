class Api::ProjectsController < ApplicationController
  def index
    @projects = User.find(params[:user_id]).created_projects

    render json: @projects
  end

  def show
    @project = Project.find(params[:id])

    render json: @project
  end
end
