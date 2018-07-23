class MatchesController < ApplicationController
    def show
        @match=Match.find(params[:id])
        @challenger=@match.challenger
        @opponent=@match.opponent
    end
    
    def new
        @challenger=User.find(session[:user_id])
        @match=Match.new
    end
    
    def create
        @match=Match.new(match_params)
        @match.save
        redirect_to match_path(@match)
    end
        
        
        
    end
    
    private
    
    def match_params
        params.require(:match).permit(:challenger_id, :opponent_id)
    end
    
end
