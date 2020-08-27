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
    return false if @fired_upon == true
    @fired_upon = true
    @ship.hit if !empty?
  end

  def fired_upon?
    @fired_upon
  end

  def render(default=false)
    return "S" if default == true && !empty? && !fired_upon?
    return "X" if !empty? && @ship.sunk?
    return "M" if fired_upon? && empty?
    return "H" if fired_upon? && !empty?
    return "." if !fired_upon?
  end
end
