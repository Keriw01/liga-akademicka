class AddTeamIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :team_id, :integer
  end
end
