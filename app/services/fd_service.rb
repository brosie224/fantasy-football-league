class FdService

    def create_new_players 
        @resp = Faraday.get 'https://api.fantasydata.net/api/nfl/fantasy/json/Players' do |req|
            req.params['key'] = ENV['FANTASY_DATA_KEY']
        end
        hashes = JSON.parse(@resp.body)
        actives = hashes.select { |player| player["Team"] }
        offense = actives.select { |player| %w(QB RB FB WR TE K).include? player["Position"] }
        @player_hash = offense.sort_by { |hash| hash["LastName"] }

        @player_hash.each do |player| 
            Player.find_or_create_by(espn_id: player["PlayerID"]) do |new_player|  # change to fd_id:
                new_player.first_name = player["FirstName"]
                new_player.last_name = player["LastName"]
                new_player.position = player["Position"]
                new_player.position = "RB" if new_player.position == "FB"
                new_player.team_id = 0
                new_player.nfl_team = player["Team"]
            end
        end
    end

    def update_nfl_teams
        @resp = Faraday.get 'https://api.fantasydata.net/api/nfl/fantasy/json/Players' do |req|
            req.params['key'] = ENV['FANTASY_DATA_KEY']
        end
        hashes = JSON.parse(@resp.body)
        actives = hashes.select { |player| player["Team"] }
        offense = actives.select { |player| %w(QB RB FB WR TE K).include? player["Position"] }
        @player_hash = offense.sort_by { |hash| hash["LastName"] }
        players = Player.all

        @player_hash.each do |fd_player| 
            players.each do |player|
                if player.espn_id == fd_player["PlayerID"] && player.nfl_team != fd_player["Team"] # change to fd_id
                    player.update(nfl_team: fd_player["Team"])
                end
            end
        end
    end

end