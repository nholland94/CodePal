class Api::ProjectFilesController < ApplicationController
  def index
    project_files = Project.find(params[:project_id]).project_files

    render json: project_files
  end
  
  def save
    files = []

    params[:files].each do |pair|
      p pair
      file = Project.find(params[:project_id]).send(pair.first + "_file")
      p file

      if file.empty?
        # maybe check params for a change in type?
        # make a new ProjectFile for that?
      else
        file.first.update_attributes(body: pair.last)
        files.push(file.first)
      end
    end

    render json: files
  end
end
