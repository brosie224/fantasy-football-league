class PlayersController < ApplicationController
    before_action :require_login
    before_action :find_team

    def index
        @players = Player.all
    end

    def add_to_team
        params[:free_agents].each do |id|
            player = Player.find(id)
            player.team_id = @team.id
            player.save
        end
        redirect_to user_path(current_user)
    end

    private

    def find_team
      @team = @team = current_user.team
    end

end
