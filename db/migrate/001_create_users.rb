class CreateUsers < ActiveRecord::Migration[5.0]
    def change
        create_table :users do |tab|
            tab.string :name #name of the user
            tab.string :stations #stations that the user has saved
            tab.string :genres #through stations
        end
    end
end 