require './test/test_helper'

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_empty_ship_array_attribute
    assert_equal [], @player.ships
  end

end
