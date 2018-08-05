class GamesController < ApplicationController
    
    
    def new
        #can add logic to handle nested match/:id/games path
        @game=Game.new
        @user=User.find(current_user)
    end
    
    def create
        @user=User.find(params[:user_id])
        @game=Game.new(game_params)
        if @game.save
            redirect_to game_path(@game)
        else
            render "new"
        end
    end
    
    def show
        @game=Game.find(params[:id].to_i)
        render json: @game, status: 200
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
