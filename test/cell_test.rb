require './test/test_helper'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
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

  def test_returns_ship_and_false_if_not_empty
    assert @cell.empty?
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_should_lower_ship_health_by_1_when_fire_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cruiser.health
  end

  def test_cannot_fire_on_same_cell_twice
    @cell.fire_upon
    assert_equal false, @cell.fire_upon
  end

  def test_should_return_boolean_if_it_has_been_fired_upon
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
    assert_equal 2, @cruiser.health
  end

  def test_should_render_depending_on_ship_status
    destroyer = Ship.new("destroyer", 2)
    cell2 = Cell.new("B4")
    cell3 = Cell.new("A1")
    cell2.place_ship(destroyer)
    cell3.place_ship(@cruiser)
    cell4 = Cell.new("A2")
    cell4.place_ship(destroyer)

    assert_equal "S", cell2.render(true)
    assert_equal ".", @cell.render(true)
    assert_equal ".", cell3.render
    cell3.fire_upon
    assert_equal "H", cell3.render
    @cell.fire_upon
    assert_equal "M", @cell.render(true)
    @cell.place_ship(destroyer)
    @cell.fire_upon
    assert_equal "H", @cell.render(true)
    cell2.fire_upon
    cell4.fire_upon
    assert_equal true, destroyer.sunk?
    assert_equal "X", @cell.render(true)
  end
end
