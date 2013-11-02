module SessionHelper
  def current_user
    return nil unless session[:session_token]
    @current_user = @current_user || User.find_by_session_token(session[:session_token])
  end

  def current_user=(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    @current_user = user
  end

  def login!(user)
    self.current_user = user
  end

  def logout!
    session[:session_token] = nil
  end

  def logged_in?
    !!self.current_user
  end
end
