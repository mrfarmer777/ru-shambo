class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image, :created_at, :win_percentage
  
  has_many :matches
  
  
end
