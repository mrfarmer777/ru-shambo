class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :created_at, :win_percentage, :record

  has_many :games, through: :matches
end
