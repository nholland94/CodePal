class ProjectMembersController < ApplicationController
  def index
    @members = Project.find(params[:id]).members
    
    render :index
  end

  def new
    @current_members = Project.all_members
    @potential_members = User.where.not(user_id: @current_members)

    render :new
  end

  def create
    @member = ProjectMember.new(project_id: params[:project_id],
                                user_id: params[:id])

    if @member.save
      redirect_to members_index_project_url(params[:id])
    else
      add_flash(:errors, @member.errors.full_messages
      redirect_to new_members_project_url(params[:id])
    end
  end

  def destroy
    @memebership = ProjectMember.find_by_project_id_and_user_id(params[:project_id],
                                                                params[:id])

    @membership.destroy
    redirect_to members_index_project_url(params[:project_id])
  end
end
