class GameSerializer < ActiveModel::Serializer
  attributes :id, :chal_throw, :opp_throw, :created_at
  belongs_to :match
end