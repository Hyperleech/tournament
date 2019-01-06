class AddTeamGameToParticipation < ActiveRecord::Migration[5.2]
  def change
	add_reference :participations, :game, index: true
	add_reference :participations, :team, index: true
  end
end
