class Match < ApplicationRecord
    belongs_to :user
    belongs_to :opponent, class_name: 'User'
    #has_many :games      #soon....
end
