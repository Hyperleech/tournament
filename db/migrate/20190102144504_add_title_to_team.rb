class AddTitleToTeam < ActiveRecord::Migration[5.2]
  def change
  	add_column :teams, :title, :string
  end
end
