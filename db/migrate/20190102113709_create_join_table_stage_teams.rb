class CreateJoinTableStageTeams < ActiveRecord::Migration[5.2]
  def change
    create_join_table :teams, :stages do |t|
      # t.index [:team_id, :stage_id]
      # t.index [:stage_id, :team_id]
    end
  end
end
