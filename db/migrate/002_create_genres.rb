class CreateGenres < ActiveRecord::Migration[5.0]
    def change
        create_table :genres do |tab|
            tab.string :name #name of the genre
            tab.string :users # users who like the genre through stations
            tab.string :stations #stations of the genre (through stations)
        end
    end
end
