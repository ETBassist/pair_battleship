require './test/test_helper'

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

end
