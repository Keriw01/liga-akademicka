class AddCreatorToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :creator, :string
  end
end
