class Station < ActiveRecord::Base
    #should have: name , users , genres

    #id done through AR
    has_many :users #the station has users/listeners
    belongs_to :users #users have many stations they "like"
    has_many :genres #stations have genres

end
