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
     
     skip "has many matches" do
         pending("tba")
     end
     
     skip "has many opponents through matches" do
         pending("tba")
     end
     
     skip "has many games through matches" do
         pending("tba")
     end
     
     describe "helper methods" do
         skip "user#record returns record of all games played by user" do
         end
         
         skip "user#plays returns a hash of all plays by throw (r,p,s)" do
         end
         
         skip "user#favorite_throw returns the user's favorite throw" do
         end
     end
     
     
 end