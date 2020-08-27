require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_has_board_as_attribute
    assert_instance_of Board, @game.board_1
    assert_instance_of Board, @game.board_2
  end
end
