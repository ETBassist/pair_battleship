class Board
  attr_reader :cells

  def initialize
    @cells = Hash.new
    ("A".."D").each do |letter|
      (1..4).each do |number|
        cell = Cell.new("#{letter}#{number}")
        @cells.store(cell.coordinate, cell)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells[coordinate] == nil ? false : true
  end

  def valid_placement?(ship, coords)
    return false if ship.length != coords.length
    return false if valid_overlapping?(coords) == false
    valid_order_and_diagonal?(coords[0], coords[-1]) == coords
  end

  def valid_order_and_diagonal?(coord1, coord2)
    new_coords = []
    if coord1[1] == coord2[1]
      letters = (coord1[0]..coord2[0]).to_a
      letters.each {|letter| new_coords << letter + coord1[1]}
    elsif coord1[0] == coord2[0]
      numbers = (coord1[1]..coord2[1]).to_a
      numbers.each {|num| new_coords << coord1[0] + num}
    end
    new_coords
  end

  def valid_overlapping?(coords)
    coords.each do |coord|
      return false if @cells[coord].empty? != true
    end
  end

  def place(ship, coords)
    if valid_placement?(ship, coords)
      coords.each do |cell|
        @cells[cell].place_ship(ship)
      end
    else
      false
    end
  end

  def render(default=false)
    "  1 2 3 4 \nA #{@cells["A1"].render(default)} #{@cells["A2"].render(default)} #{@cells["A3"].render(default)} #{@cells["A4"].render(default)}\nB #{@cells["B1"].render(default)} #{@cells["B2"].render(default)} #{@cells["B3"].render(default)} #{@cells["B4"].render(default)}\nC #{@cells["C1"].render(default)} #{@cells["C2"].render(default)} #{@cells["C3"].render(default)} #{@cells["C4"].render(default)}\nD #{@cells["D1"].render(default)} #{@cells["D2"].render(default)} #{@cells["D3"].render(default)} #{@cells["D4"].render(default)}\n"
  end
end
