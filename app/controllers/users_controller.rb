class UsersController < ApplicationController
  # attr_accessor :user
  # attr_accessor :users

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to new_session_path
      # redirect_to user_path(user)
    else
      redirect_to new_user_path
      raise "Error"
    end
  end

  def edit
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

end
