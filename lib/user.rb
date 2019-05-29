class User < ActiveRecord::Base

# Should have: name , stations , genres (through stations)
    #create: Create user
    #Read:  List all favorite stations
    #Update: Change favorite station
    #Drop: Drop a station from the saved station list

    # id done through AR
    has_many :stations
    has_many :genres, through: :stations



end
