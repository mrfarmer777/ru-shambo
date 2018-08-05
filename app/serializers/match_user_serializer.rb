class MatchUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  belongs_to :challenger, foreign_key: :challenger_id
  belongs_to :opponent, foreign_key: :opponent_id
end
