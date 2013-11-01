class ProjectsController < ApplicationController
	def index
		@projects = Project.all

		render :index
	end

	def new
		@project = Project.new

		render :new
	end

	def create
		@project = Project.new(params[:project])

		@project.creator_id = current_user.id

		if @project.save
			redirect_to project_url(@project.id)
		else
			add_flash(:errors, @project.errors.full_messages)
			redirect_to new_project_url
		end
	end

	def show
		@project = Project.find(params[:id])

		render :show
	end

	def edit
		@project = Project.find(params[:id])

		render :edit
	end

	def update
		@project = Project.find(params[:id])

		if @project.update_attributes(params[:project])
			redirect_to project_url(@project.id)
		else
			add_flash(:errors, @project.errors.full_messages)
			redirect_to edit_user_url
		end
	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to root_url
	end
end
