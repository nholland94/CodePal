class UsersController < ApplicationController
  def index
    @users = User.all

    render :index
  end

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_url
    else
      add_flash(:errors, @user.errors.full_messages)
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user.id)
    else
      add_flash(:errors, @user.errors.full_messages)
      redirect_to edit_user_url
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    add_flash(:messages, @user.username + " deleted!")
    redirect_to root_url
  end
end
