class AddStageTypeToStages < ActiveRecord::Migration[5.2]
  def change
	add_column :stages, :stage_type, :string
  end
end
