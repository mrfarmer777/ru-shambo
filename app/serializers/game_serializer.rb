class GameSerializer < ActiveModel::Serializer
  attributes :id, :chal_throw, :created_at, :status
  belongs_to :match
  class MatchSerializer < ActiveModel::Serializer
    attributes :challenger, :opponent
  end
end
