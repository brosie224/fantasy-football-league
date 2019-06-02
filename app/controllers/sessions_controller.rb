class SessionsController < ApplicationController

  def new
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
