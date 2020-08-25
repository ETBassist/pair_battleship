require './test/test_helper'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_can_access_cells_attribute
    assert_instance_of Hash, @board.cells
    @board.cells.each do |coordinate, cell|
      assert_instance_of Cell, cell
    end
  end

end
