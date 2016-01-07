class UsersController < ApplicationController
  # attr_accessor :user
  # attr_accessor :users

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # unless current_user == @user
    #   redirect_to new_user_path
    # end
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
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    updated_user = @user
    updated_user.update_attributes(update_params)
    if is_valid?(updated_user)
      if @user.update_attributes(update_params)
        return redirect_to user_path(@user)
      end
    end
    render :edit
  end

  def destroy
    session[:user_id] = nil
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:username, :profile_pic)
  end

  def is_valid? user
    if user.username != ""
      if user.profile_pic != ""
        return true
      end
    end
    return false
  end

end
