require './test/test_helper'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_can_get_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_empty_returns_true_if_no_ship
    assert @cell.empty?
  end
end
