class WelcomeController < ApplicationController
    def home
        if session[:user_id]
            @user=User.find(session[:user_id])
            redirect_to user_path(@user)
        else
            @user=User.new
        end
    end
end