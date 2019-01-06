class RemoveColumns < ActiveRecord::Migration[5.2]
  def change
 	remove_column :games, :name
 	remove_column :games, :type
 	remove_column :games, :team_1_id
 	remove_column :games, :team_2_id
 	remove_column :teams, :name
 	remove_column :stages, :type
  end
end
