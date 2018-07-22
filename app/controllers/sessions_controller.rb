class SessionsController < ApplicationController
    
    def create
        
        #Find or create the user using their uid
        #If they're there already, we pull them out and udpate them
        #If they're new, we create them and create(save them to the db)
        @user=User.find_or_create_by(uid: auth['uid']) do |u|
            u.name=auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
        end
        
        #logs in the user from above
        #using their app database id
        session[:user_id]=@user.id
        
        render 'welcome/home'
    end
        
        
        
  
    
    
    private
    
    #helper method that pulls the auth hash from the request.env
    def auth
        request.env['omniauth.auth']
    end
    
end