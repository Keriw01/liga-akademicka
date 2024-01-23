class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.integer :id_first_team
      t.integer :id_second_team
      t.datetime :date
      t.integer :team_first_score
      t.integer :team_second_score

      t.timestamps
    end
  end
end
