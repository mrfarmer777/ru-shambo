class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :created_at, :win_percentage, :active_games, :record
  
  
  has_many :matches
  
  
end
