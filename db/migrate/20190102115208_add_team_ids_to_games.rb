class AddTeamIdsToGames < ActiveRecord::Migration[5.2]
  def change
	add_column :games, :team_1_id, :integer
	add_column :games, :team_2_id, :integer
  end
end
