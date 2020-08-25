class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @ship != nil
  end

  def fired_upon?
    @fired_upon
  end

  def render(default=false)
    return "S" if default == true
    return "X" if @ship != nil && @ship.sunk?
    return "." if @fired_upon == false
    return "M" if @fired_upon == true && @ship == nil
    return "H" if @fired_upon == true && @ship != nil
  end
end
