class PlayersController < ApplicationController
    before_action :require_login
    before_action :find_team
    before_action :admin_only, only: [:new, :create, :edit, :update, :destroy]

    def index
        @players = Player.all
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
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def find_team
      @team = @team = current_user.team
    end

end
