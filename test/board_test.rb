require './test/test_helper'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("submarine", 2)
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

  def test_should_test_valid_placement_for_consecutive_coordinates
    assert_equal true, @board.valid_placement?(@cruiser, ["A1","A2","A3"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1","B1","D1"])
  end

  def test_should_test_valid_placement_for_diagonal_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ["A1","B2","C3"])
  end

  def test_should_test_valid_placement_to_return_true_if_coordinates_are_valid
    assert_equal true, @board.valid_placement?(@cruiser, ["A1","A2","A3"])
    assert_equal true, @board.valid_placement?(@submarine, ["D1","D2"])
  end
end
