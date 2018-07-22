 require 'rails_helper'
 
 RSpec.describe User, :type => :model do
     let(:user) {
        User.create(
            :name=>"Morty", 
            :email=>"morty@gmail.com"
        )
         
     }
     
     it "is valid with a name and email" do
         expect(user).to be_valid
     end
 end