class PlayersController < ApplicationController
    before_action :require_login
    before_action :find_player, only: [:edit, :update, :destroy]
    before_action :find_team, only: [:free_agents, :add_to_team]
    before_action :admin_only, except: [:index, :free_agents, :add_to_team]

    def index
      @players = Player.all.order(:last_name, :first_name).sort_position
    end

    def free_agents
        @players = Player.free_agents.order(:last_name, :first_name).sort_position
    end

    def add_to_team
        params[:free_agents].each do |fa_id|
            player = Player.find(fa_id)
            player.team_id = @team.id
            player.save
        end
        redirect_to user_path(current_user)
    end

    # Admin Only
    
    def new
        @player = Player.new
    end

    def create
        @player = Player.create(player_params)
        if @player.valid?
          flash[:notice] = "#{@player.position} #{@player.full_name} has been created."
          redirect_to new_player_path
        else
          flash[:alert] = @player.errors.full_messages
          render :new
        end
    end

    def edit
    end

    def update
        @player.update(player_params)
        if @player.valid?
          flash[:notice] = "#{@player.position} #{@player.full_name} has been updated."
          redirect_to players_path
        else
          flash[:alert] = @player.errors.full_messages
          render :edit
        end
    end

    def destroy
        @player.destroy
        redirect_to players_path
    end

    private

    def find_player
        @player = Player.find_by(id: params[:id])
    end

    def find_team
      @team = @team = current_user.team
    end

    def player_params
        params.require(:player).permit(:first_name, :last_name, :position, :espn_id, :team_id)
    end

end
