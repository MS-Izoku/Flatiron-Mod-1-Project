class Selection < ActiveRecord::Base
    belongs_to :stations
    belongs_to :users
end
