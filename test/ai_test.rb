require './test/test_helper'
require 'mocha/minitest'

class AITest < Minitest::Test
  def setup
    @ai = AI.new
    @ai_player = Player.new
    @board = Board.new
    @ai_player.board = @board
    @ship = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of AI, @ai
    assert_instance_of Board, @ai_player.board
  end

  def test_ship_bucket_is_array
    assert_equal [], @ai.ai_ship_bucket
  end

  def test_can_add_ships_to_bucket
    assert_equal [], @ai.ai_ship_bucket
    @ai.ai_ship_bucket << @ship
    assert_equal [@ship], @ai.ai_ship_bucket
  end

  def test_can_generate_coordinates_for_ship_placement
    @ai.ai_ship_bucket << @ship
    @ai.generate_coords(["A", "B", "C"], [1], @ai_player)
    assert_equal false, @ai_player.has_lost?
    assert_equal false, @ai_player.board.cells["A1"].empty?
    assert_equal false, @ai_player.board.cells["B1"].empty?
    assert_equal false, @ai_player.board.cells["C1"].empty?
    assert @ai_player.board.cells["A4"].empty?
    ship2 = Ship.new("Destroyer", 2)
    @ai.ai_ship_bucket << ship2
    @ai.generate_coords([1, 2], ["D"], @ai_player)
    assert_equal false, @ai_player.board.cells["D1"].empty?
    assert_equal false, @ai_player.board.cells["D2"].empty?
  end

  def test_ai_can_fire_upon_board
    board2 = Board.new
    @ai.ai_fire_upon(["A1"], board2, @ai_player)
    assert_equal "A1", @ai_player.last_shot.coordinate
    assert board2.cells["A1"].fired_upon?
  end

end
