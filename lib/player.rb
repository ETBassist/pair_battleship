class Player
  attr_reader :ships, :board, :last_shot

  def initialize
    @board = nil
    @ships = []
    @last_shot = nil
  end

  def add_ship(ship)
    @ships << ship
  end

  def has_lost?
    @ships.all? do |ship|
      ship.sunk?
    end
  end

end
