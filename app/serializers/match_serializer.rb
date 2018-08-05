class MatchSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :opponent_name, :game_count, :record
  belongs_to :challenger, foreign_key: "challenger_id", class_name: "User" , serializer: MatchUserSerializer
  belongs_to :opponent, foreign_key: "opponent_id", class_name: "User", serializer: MatchUserSerializer
  
  has_many :games
  class GameSerializer < ActiveModel::Serializer
    attributes :id, :status, :result
  end
end
