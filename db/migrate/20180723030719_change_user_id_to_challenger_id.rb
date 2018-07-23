class ChangeUserIdToChallengerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :matches, :user_id, :challenger_id
  end
end
