class ChangeGameToChildObject < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :match_2_id
    rename_column :games, :match_1_id, :match_id
  end
end
