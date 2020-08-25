require './test/test_helper'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_can_access_attributes
    assert_equal 3, @cruiser.length
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.health
  end

  def test_hit_and_sunk_method
    assert_equal false, @cruiser.sunk?
    assert_equal 3, @cruiser.health
    @cruiser.hit
    assert_equal 2, @cruiser.health
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal 0, @cruiser.health
    assert @cruiser.sunk?
  end

end
