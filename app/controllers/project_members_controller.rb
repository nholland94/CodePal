class ProjectMembersController < ApplicationController
  def index
    @members = Project.find(params[:id]).all_members
    
    render :index
  end

  def new
    project = Project.find(params[:id])
    @users = User.where('id != ?', project.creator_id)
    @member_ids = project.members.map { |member| member.id }

    render :new
  end

  def create
    @member_ids = Project.find(params[:id]).members.map { |member| member.id }

    params[:member].each do |pair|
      if pair.last == "on" && !@member_ids.include?(pair.first.to_i)
        member = ProjectMember.new(project_id: params[:id],
                                   user_id: pair.first.to_i)
        unless member.save
          add_flash(:errors, member.errors.full_messages)
        end
      end
    end
    
    redirect_to members_project_url(params[:id])
  end

  def destroy
    @memebership = ProjectMember.find_by_project_id_and_user_id(params[:project_id],
                                                                params[:id])

    @membership.destroy
    redirect_to members_project_url(params[:project_id])
  end
end
