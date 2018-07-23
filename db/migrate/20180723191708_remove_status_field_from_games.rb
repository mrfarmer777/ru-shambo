class RemoveStatusFieldFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :status
  end
end
