class SessionsController < ApplicationController

  def new
    @user = User.new
    redirect_to root_path
  end

  def create
    user = User.where(email: user_params[:email]).first
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Incorrect log in information"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:sucess] = "You have been logged out"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
