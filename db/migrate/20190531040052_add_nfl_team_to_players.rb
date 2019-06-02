class AddNflTeamToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :nfl_team, :string
  end
end
