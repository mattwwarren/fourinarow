class Game < ActiveRecord::Base
  attr_accessible :board, :color, :id, :name
end
