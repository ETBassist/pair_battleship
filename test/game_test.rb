require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_has_board_as_attribute
    assert_instance_of Board, @game.player_board
    assert_instance_of Board, @game.ai_board
  end
end
