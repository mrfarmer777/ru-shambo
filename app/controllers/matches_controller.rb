class MatchesController < ApplicationController

    
    #show the details of a single match
    def show
        @user=User.find(current_user);
        @match=Match.find(params[:id])
        @all_games=Game.match_games(@match.id)
        @active_games=@all_games.select{|g| !g.complete?}
        @challenger=@match.challenger
        @opponent=@match.opponent
    end
    
    #index the matches (for a user) 
    #Nested route: /users/:uesr_id/matches/:id
    def index
        @user=User.find(params[:user_id])
        @matches=@user.matches
    end
    
    #renders the new match form
    def new
        @challenger=User.find(session[:user_id])
        @match=Match.new
    end
    
    #creates a new match instance
    def create
        if params[:user_id]
            @user=User.find(params[:user_id].to_i)
            #Prevents user from starting match with themselves
            
                #Prevents a redundant match from being created
                #Necessary because of the self-join implementation
                #LETTING VALIDATIONS HANDLE THIS....
                #if Match.exists?(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
                #   flash[:message]="Match already exists. Try making a new game for this match instead."
                #    render "new"
                #else
                    #Create a new match
            @match=Match.new(challenger_id: @user.id, opponent_id: match_params[:opponent_id])
            if @match.save #When created, an inverse match is also automatically created
                redirect_to user_path(@user)
            else
                render :"users/show"
            end
            
        else
            flash[:message]="Something was wrong with your id"
            render :"users/show"
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
