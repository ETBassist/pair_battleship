require './test/test_helper'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
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

  def test_should_return_boolean_if_coordinate_exists_or_not
    assert_equal false, @board.valid_coordinate?("H1")
    assert_equal false, @board.valid_coordinate?("D0")
    assert_equal false, @board.valid_coordinate?("A61")
    assert_equal false, @board.valid_coordinate?("!5")
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("C4")
  end

  def test_should_test_valid_placement_for_length_of_ship
    assert_equal true, @board.valid_placement?(@cruiser, ["A1","B1","C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1","B1","C1","D1"])
  end
end
