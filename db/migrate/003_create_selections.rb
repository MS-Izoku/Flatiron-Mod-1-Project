class CreateSelections < ActiveRecord::Migration[5.0]
    def change
        create_table :selections do |tab|
            #tab.string :name
            tab.belongs_to :station, index: true
            tab.belongs_to :user, index: true
        end
    end
end
