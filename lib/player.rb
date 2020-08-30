class Player
  attr_reader :ships

  def initialize
    @board = nil
    @ships = []
    @last_shot = nil
  end
end
