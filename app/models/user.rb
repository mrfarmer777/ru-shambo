class User < ApplicationRecord
    has_many :matches, foreign_key: "challenger_id"
    has_many :opponents, through: :matches
    has_many :games, through: :matches
    validates :name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
    validates :email, uniqueness: true
    has_secure_password
    
    #///////////CLASS METHODS/////////////////////
    
    def self.find_or_create_by_omniauth(auth_hash)
        
        #extracts email from request.env auth hash
        oauth_email=auth_hash["info"]["email"]
        oauth_name=auth_hash["info"]["name"]
        oauth_uid=auth_hash["info"]["uid"]
        oauth_image=auth_hash["info"]["image"]

        
        #Will always return a user instance
        #either one that was created with these parameters, or one that has just been assigned
        self.where(uid:oauth_uid).first_or_create do |user|
            #will only run when a user created!? AWESOME
            user.password=SecureRandom.hex
            user.name=oauth_name
            user.email=oauth_email
            user.image=oauth_image
        end
        
        #If we've already got this user...
        if user=User.find_by(email: oauth_email)
            #get the user and hand them back to the session controller
            return user
        #If they're a new user through oauth...
        else
            #make a new user using their email, set a randomized password (so no one else can hack in through the local login method?)
            #Want to make new users with more than email in the future...
            user.User.create(:email=>oauth_email, password: SecureRandom.hex)
            
            if user.save
                session[:user_id] = user.id
                redirect_to root_path
            else
                raise user.errors.full_messages.inspect
            end
        end
    end
    
    #////////////VIEW HELPERS/////////////////////
    def active_games
        self.games.select{|g| !g.complete?}
    end
    
            
            
    
    
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
        if self.games.count>0
            self.wins/(self.games.count)
        else
            0
        end
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
