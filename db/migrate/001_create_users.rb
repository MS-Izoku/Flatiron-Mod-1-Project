class CreateUsers < ActiveRecord::Migration[5.0]
    def change
        create_table :users do |tab|
            tab.string :name
            tab.string :favorite_genre        
        end
    end
end 