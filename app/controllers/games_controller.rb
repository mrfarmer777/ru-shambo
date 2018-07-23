class GamesController < ApplicationController
    
    
    def new
        @game=Game.new
        @user=User.find(session[:user_id])
    end
    
    def create
       @match=Match.find(game_params[:match_id])
       @match.games.build(game_params)
       @match.save #? Necessary?
       redirect_to user_path(session[:user_id])
    end
       
       
    
    
    private
    
    def game_params
        params.require(:game).permit(:match_id, :chal_throw, :opp_throw)
    end

end
