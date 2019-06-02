class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :espn_id
      t.integer :team_id

      t.timestamps
    end
  end
end
