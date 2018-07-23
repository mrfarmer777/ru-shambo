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
        @user=User.find(session[:user_id])
        if @user.id==match_params[:opponent_id].to_i
            flash[:message]="Sorry, you can't (umm..) challenge yourself."
            render "matches/new"
        else
            if Match.exists?(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
                flash[:message]="Match already exists. Try making a new game for this match."
                render "new"
            else
                @match=Match.new(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
                @match.save
                redirect_to match_path(@match)
            end
        end
    end
        
        
        
    
    
    private
    
    def match_params
        params.require(:match).permit(:challenger_id, :opponent_id)
    end
    
end
