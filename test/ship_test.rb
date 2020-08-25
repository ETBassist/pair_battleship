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
end
