module UsersHelper
  def require_self
    unless current_user.id == params[:id]
      if logged_in?
        redirect_to root_url
      else
        redirect_to login_url
      end
    end
  end
end
