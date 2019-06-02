class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages
      render :new
    end
  end

  def show
    if @user.team
      @team = @user.team
      @players = @team.players if @team.players
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def authenticate_user
    if @user.id != current_user.id
      flash[:notice] = "Users can only edit their own profile."
      redirect_to user_path(current_user)
    end 
  end
    
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end