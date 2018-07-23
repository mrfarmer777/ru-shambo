class UsersController < ApplicationController
    
    
    def show
        #Is the user trying to view their own page?
        if session[:user_id]==params[:id].to_i
            #if so, move along
            @user=User.find(params[:id].to_i)
            @games=@user.games
        else
            #if not, back to root which will send you to your own show page
            redirect_to root_path
        end
    end
    
    def edit
        if session[:user_id]==params[:id].to_i
            @user=User.find(params[:id].to_i)
        else
            redirect_to user_path(User.find(session[:user_id]))
        end
    end
    
    def index
        @users=User.all
    end
    
    
    
end
