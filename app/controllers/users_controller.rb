class UsersController < ApplicationController
    
    def new
        @user=User.new
    end
    
    def create
        if @user=User.create(user_params)
            session[:user_id]=@user.id
            redirect_to user_path(@user)
        else
            render 'users/new'
        end
    end
    
    
    def show
        #Is the user trying to view their own page?
        if session[:user_id]==params[:id].to_i
            #if so, move along
            @user=User.find(params[:id].to_i)
            @match=Match.new
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
    
    private 
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :image, :uid)
    end
    
end
