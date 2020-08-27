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
    expected = ["A1","A2","A3"]
    assert_equal expected, @board.valid_order_and_diagonal?("A1","A3")
    assert_equal false, (expected == @board.valid_order_and_diagonal?("A1","A4"))
    assert_equal false, (expected == @board.valid_order_and_diagonal?("C1","A1"))
  end

  def test_should_test_valid_placement_for_diagonal_coordinates
    assert_equal false, ([] != @board.valid_order_and_diagonal?("A1","B2"))
  end

  def test_should_test_valid_placement_to_return_true_if_coordinates_are_valid
    assert_equal true, @board.valid_placement?(@cruiser, ["A1","A2","A3"])
    assert_equal true, @board.valid_placement?(@submarine, ["D1","D2"])
  end

  def test_can_place_ship_on_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @board.cells["A1"].ship
    assert_equal @cruiser, @board.cells["A2"].ship
    assert_equal @cruiser, @board.cells["A3"].ship
  end

  def test_should_return_boolean_if_ships_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.cells["A1"].empty?
    assert_equal false, @board.place(@submarine, ["A1", "B1"])
  end

  def test_render_method
    test_board = "  1 2 3 4 \nA . . . .\nB . . . .\nC . . . .\nD . . . .\n"
    assert_equal test_board, @board.render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    test_board_true = "  1 2 3 4 \nA S S S .\nB . . . .\nC . . . .\nD . . . .\n"
    assert_equal test_board_true, @board.render(true)
    @board.cells["B1"].fire_upon
    test_board_hit = "  1 2 3 4 \nA S S S .\nB M . . .\nC . . . .\nD . . . .\n"
    assert_equal test_board_hit, @board.render(true)
    @board.cells["A1"].fire_upon
    test_board_ship_hit = "  1 2 3 4 \nA H S S .\nB M . . .\nC . . . .\nD . . . .\n"
    assert_equal test_board_ship_hit, @board.render(true)
    @board.cells["A2"].fire_upon
    @board.cells["A3"].fire_upon
    test_board_ship_sunk = "  1 2 3 4 \nA X X X .\nB M . . .\nC . . . .\nD . . . .\n"
    assert_equal test_board_ship_sunk, @board.render(true)
  end
end
