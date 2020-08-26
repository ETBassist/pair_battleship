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
    @ship.hit if empty? == false
  end

  def fired_upon?
    @fired_upon
  end

  def render(default=false)
    return "S" if default == true && empty? == false && fired_upon? == false
    return "X" if empty? == false && @ship.sunk?
    return "M" if fired_upon? && empty?
    return "H" if fired_upon? && empty? == false
    return "." if fired_upon? == false
  end
end
