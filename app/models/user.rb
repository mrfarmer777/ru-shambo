class User < ApplicationRecord
    has_many :matches, foreign_key: "challenger_id"
    has_many :opponents, through: :matches
    has_many :games, through: :matches
    validates :name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
    validates :email, uniqueness: true
    validates :uid, presence: true
    validates :uid, numericality: {only_integer: true}
    validates :uid, uniqueness: true
    
end
