class ChangeEventDataTypes < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :name_first_team, :string
    change_column :events, :name_second_team, :string
  end
end
