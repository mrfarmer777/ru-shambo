class Match < ApplicationRecord
    belongs_to :challenger, foreign_key: "challenger_id", class_name: "User" 
    belongs_to :opponent, class_name: "User"
    #has_many :games      #soon....
    
    after_create :create_inverse, unless: :has_inverse?
    after_destroy :destroy_inverses, if: :has_inverse?
    
    #creates a second, inverse match for reciprocity with opponent
    def create_inverse
        self.class.create(inverse_match_options)
    end
    
    #checks if a match already has an inverse set up
    def has_inverse?
        self.class.exists?(inverse_match_options)
    end
    
    
    #destroys all inverses when a instance is destroyed
    def destroy_inverses
        inverses.destroy_all
    end
    
    #finds all inverse matches for a given match, 
    #WE CAN ONLY HAVE ONE MATCH PER PAIR!
    def inverses
        self.class.where(inverse_match_options)
    end
    
    #returns reversed params for an inverse match
    def inverse_match_options
        {challenger_id: opponent_id, opponent_id: challenger_id}
    end
end
