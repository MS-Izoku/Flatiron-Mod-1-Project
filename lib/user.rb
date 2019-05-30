class User < ActiveRecord::Base
    has_many :selections
    has_many :stations, through: :selections
end
