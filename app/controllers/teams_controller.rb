class TeamsController < ApplicationController
    before_action :find_team, only: [:edit, :update, :destroy]
    before_action :authenticate_team, only: [:edit, :update, :destroy]

    def index
        @teams = Team.all
        # can DRY view?
    end

    def new
        @team = Team.new(user_id: params[:user_id])
    end

    def create
        @team = Team.create(team_params)
        if @team.valid?
          redirect_to user_path(id: params[:team][:user_id])
        else
          flash[:alert] = @team.errors.full_messages
          render :new
        end
    end

    def edit
    end

    def update
      @team.update(team_params)
      if @team.valid?
        redirect_to user_path(current_user)
      else
        flash[:alert] = @team.errors.full_messages
        render :edit
      end
    end

    def destroy
      @team.players.each do |player|
        player.team_id = 0
        player.save
      end
      @team.destroy
      redirect_to user_path(current_user)
    end

    private

    def find_team
      @team = Team.find_by(id: params[:id])
    end

    def authenticate_team
      if @team.user_id != current_user.id
        flash[:alert] = "Users can only edit their own team."
        redirect_to user_path(current_user)
      end 
    end
      
    def team_params
      params.require(:team).permit(:city, :name, :conference, :division, :user_id)
    end

end
