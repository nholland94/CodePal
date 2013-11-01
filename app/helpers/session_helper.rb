module SessionHelper
	def current_user
    return nil unless session[:session_token]
		User.find_by_session_token(session[:session_token])
	end

	def current_user=(user)
		user.reset_session_token
		session[:session_token] = user.session_token
	end

	def login!(user)
		current_user = user
	end

	def logout!
		session[:session_token] = nil
	end
end
