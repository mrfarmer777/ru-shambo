class UserActiveGamesSerializer < ActiveModel::Serializer
  attributes :id, :active_games
  has_many :games, serializer: UserActiveGamesSerializer
end
