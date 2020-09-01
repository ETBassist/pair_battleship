require './lib/cell'
class Board
  attr_reader :cells, :letters, :board_size, :numbers

  def initialize(board_size=4)
    @board_size = board_size
    @cells = Hash.new
    @letters = create_letters
    @numbers = (1..@board_size).to_a
    create_board
  end

  def create_letters
    letters = []
    letter = "A"
    letters << letter
    (@board_size - 1).times do
      letter = letter.next
      letters << letter
    end
    letters
  end

  def create_board
    @letters.each do |letter|
      @numbers.each do |number|
        cell = Cell.new("#{letter}#{number}")
        @cells.store(cell.coordinate, cell)
      end
    end
  end

  def valid_coordinate?(coordinate)
    !(@cells[coordinate]).nil?
  end

  def valid_placement?(ship, coords)
    coords.each do |coord|
      return false if !valid_coordinate?(coord)
    end
    return false if ship.length != coords.length
    return false if !valid_overlapping?(coords)
    valid_order_and_diagonal?(coords[0], coords[-1]) == coords
  end

  def valid_order_and_diagonal?(coord1, coord2)
    new_coords = []
    if coord1[1..-1] == coord2[1..-1]
      letters = (coord1[0]..coord2[0]).to_a
      letters.each {|letter| new_coords << letter + coord1[1..-1]}
    elsif coord1[0] == coord2[0]
      numbers = (coord1[1..-1]..coord2[1..-1]).to_a
      numbers.each {|num| new_coords << coord1[0] + num}
    end
    new_coords
  end

  def valid_overlapping?(coords)
    coords.all? do |coord|
      @cells[coord].empty?
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
    board = "  "
    @numbers.each do |number|
      board += "#{number} "
      if number.digits.count < 2
        board += " "
      end
    end
    board += "\n"
    @letters.each do |letter|
      board += letter
        @numbers.each do |number|
          board += " #{@cells["#{letter}#{number}"].render(default)} "
        end
      board += "\n"
    end
    board
  end
end
