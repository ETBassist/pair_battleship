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
end
