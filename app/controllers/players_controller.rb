class PlayersController < ApplicationController
    before_action :require_login
    before_action :find_player, only: [:show, :previous, :next, :edit, :update, :destroy]
    before_action :find_team, only: [:free_agents, :add_to_team]
    before_action :admin_only, except: [:index, :free_agents, :add_to_team, :show, :previous, :next]

    def index # list only players who have a TLFL team
      @players = Player.all.order(:last_name, :first_name).sort_position
      respond_to do |f|
        f.html
        f.json {render json: Player.all.order(:last_name, :first_name)}
      end
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

    def show
      @first_player = Player.first
      @last_player = Player.last
      respond_to do |f|
        f.html
        f.json {render json: @player}
      end
    end

    def previous
    @previous_player = @player.previous
    render json: @previous_player
    end

    def next
      @next_player = @player.next
      render json: @next_player
    end

    # -- Admin Only --
    
    def new
        @player = Player.new
    end

    def create_from_fd
      fds = FdService.new
      fds.create_new_players
      redirect_to players_path
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
        respond_to do |f|
          f.html {redirect_to players_path, notice: "#{@player.position} #{@player.full_name} has been deleted."}
          f.json {head :no_content}
        end
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
