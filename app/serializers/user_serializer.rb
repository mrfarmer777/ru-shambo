class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :created_at, :win_percentage, :record
  
  
  
  has_many :matches
  class MatchSerializer < ActiveModel::Serializer
     attributes :id, :opponent_name, :active_games_count
  end
  
  
  
  has_many :games, through: :matches
  class GameSerializer < ActiveModel::Serializer
    attributes :id, :opponent_name, :status    
  end
  
end
