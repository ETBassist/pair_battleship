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

  def test_it_can_add_ships
    cruiser = Ship.new("Cruiser", 3)
    @player.add_ship(cruiser)
    assert_equal [cruiser], @player.ships
  end

  def test_has_lost_when_total_ships_health_zero
    cruiser = Ship.new("Cruiser", 3)
    destroyer = Ship.new("Destroyer", 2)
    @player.add_ship(cruiser)
    @player.add_ship(destroyer)
    assert_equal false, @player.has_lost?
    destroyer.hit
    destroyer.hit
    cruiser.hit
    cruiser.hit
    cruiser.hit
    assert_equal true, destroyer.sunk?
    assert_equal true, cruiser.sunk?
    assert_equal true, @player.has_lost?
  end

end
