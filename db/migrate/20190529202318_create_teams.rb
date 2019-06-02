class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :city
      t.string :name
      t.string :conference
      t.string :division
      t.integer :user_id

      t.timestamps
    end
  end
end
