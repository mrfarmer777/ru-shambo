class MatchesController < ApplicationController
    
    #show the details of a single match
    def show
        @match=Match.find(params[:id])
        @challenger=@match.challenger
        @opponent=@match.opponent
    end
    
    #renders the new match form
    def new
        @challenger=User.find(session[:user_id])
        @match=Match.new
    end
    
    #creates a new match instance
    def create
        #improved validations needed
        @user=User.find(session[:user_id])
        
        #Prevents user from starting match with themselves
        if @user.id==match_params[:opponent_id].to_i
            flash[:message]="Sorry, you can't (umm..) challenge yourself."
            render "matches/new"
        else
            #Prevents a redundant match from being created
            #Necessary because of the self-join implementation
            if Match.exists?(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
                flash[:message]="Match already exists. Try making a new game for this match."
                render "new"
            else
                #Create a new match
                @match=Match.new(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
                @match.save #When created, an inverse match is also automatically created
                redirect_to match_path(@match)
            end
        end
    end
    
    #destroys a match instance
    def destroy
        Match.find(params[:id]).destroy #When destroyed, the inverse match is also automatically destroyed.
        flash[:message]="Match deleted!"
        redirect_to user_path(User.find(session[:user_id]))
    end
    
        
        
        
    
    
    private
    
    def match_params
        params.require(:match).permit(:challenger_id, :opponent_id)
    end
    
end
