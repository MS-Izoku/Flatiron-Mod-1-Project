class Genre < ActiveRecord::Base
    # should have: name , stations(which have the genre),  users (through stations)

    #id given via AR
    belongs_to :station #stations have a genre (many if I have time to implement)
    belongs_to :user    #user has many "liked" genres
end
