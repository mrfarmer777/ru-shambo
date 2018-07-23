class Game < ApplicationRecord
    belongs_to :match
    
    after_create :create_inverse, unless: :has_inverse?
    after_destroy :destroy_inverse, if: :has_inverse?
    
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
    
    
    def inverse_game_options
        {chal_throw: opp_throw, opp_throw: chal_throw}
    end
end
