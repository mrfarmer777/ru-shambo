class User < ApplicationRecord
    has_many :matches, foreign_key: "challenger_id"
    has_many :opponents, through: :matches
    has_many :games, through: :matches
    validates :name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
    validates :email, uniqueness: true
    validates :uid, presence: true
    validates :uid, numericality: {only_integer: true}
    validates :uid, uniqueness: true
    
    
    def wins
        self.games.count{|g| g.result.include?("Congratulations")}
    end
    
    def losses
        self.games.count{|g| g.result.include?("Sorry")}
    end
    
    def draws
        self.games.count{|g| g.result.include?("Draw")}
    end
    
    def record
        "#{self.wins}-#{self.losses}-#{self.draws}"
    end
    
    def win_percentage
        self.wins/(self.games.count)
    end
    
    def favorite_throw
        throws=["r","p","s"]
        throw_arr=throws.collect{|t| self.games.count{|g| g.chal_throw==t}}
        throws[throw_arr.each_with_index.max[1]]
    end
    
    def favorite_opponent
        match=self.matches.max_by{|m| m.game_count}
        match.opponent_name
    end
end
