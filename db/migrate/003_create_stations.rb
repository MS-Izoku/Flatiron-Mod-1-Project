class CreateStations < ActiveRecord::Migration[5.0]
    def change
        create_table :stations do |tab|
            tab.string :name    #name of the station
            tab.string :users   #users who listen to the station
            tab.string :genres  #genre/s of the station
        end
    end
end
