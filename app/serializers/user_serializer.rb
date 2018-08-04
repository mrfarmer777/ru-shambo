class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image, :created_at
  has_many :matches
end
