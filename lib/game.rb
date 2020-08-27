require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board_1, :board_2

  def initialize
    @board_1 = Board.new
    @board_2 = Board.new
  end

end
