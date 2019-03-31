class UserGamesSerializer < ActiveModel::Serializer
  attributes :id, :opponent_name, :status
  belongs_to :challenger, class_name: User
end
