class AddGenreToStations < ActiveRecord::Migration[5.0]
    def change
        add_column :stations, :genre, :string
    end
end