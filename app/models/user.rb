class User < ApplicationRecord
    has_many :matches
    has_many :opponents, through: :matches, class_name: "User"
end
