class User < ApplicationRecord
    has_many :matches, foreign_key: "challenger_id"
    has_many :opponents, through: :matches
end
