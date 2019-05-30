class CreateStations < ActiveRecord::Migration[5.0]
    def change
        create_table :stations do |tab|
            tab.string :name
            tab.string :host
        end
    end
end
