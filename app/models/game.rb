class Game < ApplicationRecord
    belongs_to :match
    
    after_create :create_inverse, unless: :has_inverse?
    after_destroy :destroy_inverse, if: :has_inverse?
    after_update :update_inverse, unless: :updated?
    
    
    #Game reciprocity helpers
    def create_inverse
        recip_game=self.class.new(inverse_game_options)
        recip_game.match_id=(self.match.inverses.first.id)
        recip_game.recip_game_id=self.id
        recip_game.save
        self.recip_game_id=recip_game.id
        self.save
    end
    
    def has_inverse?
        self.recip_game_id.present?
    end
    
    def inverse
        Game.find(self.recip_game_id)
    end
    
    def destroy_inverse
        inv=self.inverse
        inv.update(recip_game_id:nil)
        self.inverse.destroy
    end
    
    def update_inverse
        inv=self.inverse
        inv.update(chal_throw:self.opp_throw, opp_throw: self.chal_throw)
    end
    
    def updated?
        inv=self.inverse
        (self.chal_throw==inv.opp_throw && self.opp_throw==inv.chal_throw && self.recip_game_id==inv.id && self.id==inv.recip_game_id)
    end
    
    
    def inverse_game_options
        {chal_throw: opp_throw, opp_throw: chal_throw}
    end
    
    #Game Logic Helpers
    
    def complete?
        opp_throw.present? && chal_throw.present?
    end
    
    def draw?
        self.complete? && opp_throw==chal_throw
    end
    
    def beat_throw(throw)
        if(throw=="r")
            "p"
        elsif(throw=="p")
            "s"
        elsif(throw=="s")
            "r"
        else
            "invalid move"
        end
    end
    
    def winner
        if chal_throw==beat_throw(opp_throw)
            self.match.challenger
        elsif opp_throw==beat_throw(chal_throw)
            self.match.opponent
        else
            nil
        end
    end
    
    def status
        if chal_throw.nil?
            "Your Throw"
        elsif opp_throw.nil?
            "Waiting for Opponent"
        elsif draw?
            "Draw"
        elsif complete?
            "Won"
        end
    end
            
        
            
            
    
end
