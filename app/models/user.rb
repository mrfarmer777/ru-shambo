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
    
    
    #////////////STATS HELPERS/////////////////////
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
        throw_to_string={"r"=>"rock","p"=>"paper","s"=>"scissors"}
        throws=["r","p","s"]
        throw_arr=throws.collect{|t| self.games.count{|g| g.chal_throw==t}}
        throw_to_string[throws[throw_arr.each_with_index.max[1]]]
    end
    
    def favorite_opponent
        match=self.matches.max_by{|m| m.game_count}
        match.opponent_name
    end
    
    def points
        (self.wins*2)+(self.draws*1)-(self.losses*1)
    end
    
    def win_p_rank
        User.rank_by_win_percentage.index(self)+1
    end
    
    def points_rank
        User.rank_by_points.index(self)+1
    end
    
    #////////////RANKING HELPERS (OBJECT SCOPE)/////////////////////
    def self.rank_by_win_percentage
        User.all.sort_by{|u| u.win_percentage}
    end
    
    def self.rank_by_points
        User.all.sort_by{|u| u.points}
    end
    

end
