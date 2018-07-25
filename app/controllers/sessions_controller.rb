class SessionsController < ApplicationController
    
    def create
        if auth_hash    #If an auth_hash (using helper below) was passed, a user is coming from omniauth
            user=User.find_or_create_by_omniauth(auth_hash) #pass them to this class method to get them from the database
            session[:user_id]=user.id
            redirect_to root_path
        else
            #Normal login with username and password
            user=User.find_by(email: session_params[:email])
            if user && user.authenticate(session_params[:password])
                session[:user_id]=user.id
                redirect_to root_path
            else
                flash[:message]="Incorrect email or password. Please try again."
                render 'sessions/new'
            end
        end
    end
        
    def destroy
        session.delete :user_id
        redirect_to root_path
    end
        
        
  
    
    
    private
    
    #helper method that pulls the auth hash from the request.env
    def auth_hash
        request.env['omniauth.auth']
    end
    
    def session_params
        params.require(:user).permit(:email, :password)
    end
    
    
    
end