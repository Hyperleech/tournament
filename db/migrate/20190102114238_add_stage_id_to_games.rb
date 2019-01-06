class AddStageIdToGames < ActiveRecord::Migration[5.2]
  def change
	add_reference :games, :stage, index: true
  end
end
