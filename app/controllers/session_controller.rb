class SessionController < ApplicationController
	def new
		render :new
	end

	def create
		@user = User.find_by_username(params[:user][:username])

		if @user.is_password?(params[:user][:password])
			login!(@user)
		else
			add_flash(:errors, @user.errors.full_messages)
			redirect_to login_url
		end
	end

	def destroy
		logout!
		redirect_to root_url
	end
end
