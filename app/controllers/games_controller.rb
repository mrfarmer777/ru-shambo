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
    
    def show
        @game=Game.find(params[:id].to_i)
        @match=@game.match
        @user=User.find(session[:user_id])
    end
    
    def update
        @game=Game.find(params[:id])
        @game.update(chal_throw:game_params[:chal_throw])
        redirect_to game_path(@game)
    end
    
       
       
    
    
    private
    
    def game_params
        params.require(:game).permit(:match_id, :chal_throw, :opp_throw)
    end

end
