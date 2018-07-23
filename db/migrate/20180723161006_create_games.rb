class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :chal_throw
      t.string :opp_throw
      t.string :status, default: "in-progress"
      t.integer :match_1_id
      t.integer :match_2_id

      t.timestamps
    end
  end
end
