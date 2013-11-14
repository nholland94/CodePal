module ProjectsHelper
  def require_creator!
    redirect_to root_url unless Project.find(params[:id]).creator_id == current_user.id
  end
end
