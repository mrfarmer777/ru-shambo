class Match < ApplicationRecord
    #basic relationships
    belongs_to :challenger, foreign_key: "challenger_id", class_name: "User" 
    belongs_to :opponent, class_name: "User"
    has_many :games

    #basic match validations
    validates :challenger_id, :opponent_id, presence: true
    validates_associated :challenger
    validates_associated :opponent
    
    #Ensure a single one-way match can exist between each any 2 users (reciprication ok)
    validates :opponent_id, uniqueness: {scope: :challenger_id}
    
    #Handling automatic reciprocity for matches
    #After each match is created, create its inverse automatically
    after_create :create_inverse, unless: :has_inverse?
    #Destroy them both when one is destroyed.
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
    
    #Returns human-readable description for debugging and possibly other things.
    def description
        "Match Details - #{self.id}: Challenger: #{self.challenger.name} vs. Opponent: #{self.opponent.name}"
    end

    def opponent_name
        self.opponent.name
    end
    
    def challenger_name
        self.challenger.name
    end
    
    def game_count
        self.games.count
    end
    
    def chal_wins
        self.games.select{|g| g.result.include?("Congratulations")}.count
    end
    
    def chal_losses
        self.games.select{|g| g.result.include?("Sorry")}.count
    end
    
    def draws
        self.games.select{|g| g.result.include?("Draw")}.count
    end
    
    def record
        "#{self.chal_wins}-#{self.chal_losses}-#{self.draws}"
    end
    
end
