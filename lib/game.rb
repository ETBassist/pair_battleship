require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

end
