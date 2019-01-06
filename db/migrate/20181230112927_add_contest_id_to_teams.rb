class AddContestIdToTeams < ActiveRecord::Migration[5.2]
  def change
  	add_reference :teams, :contest, index: true
  end
end
