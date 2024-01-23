class RemoveFieldCreatorTeam < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :creator, :string
  end
end
