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

  def place(ship, coords)
    if valid_placement?(ship, coords)
      coords.each do |cell|
        @cells[cell].place_ship(ship)
      end
    end
  end
end
