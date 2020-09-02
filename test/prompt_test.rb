require './test/test_helper'

class PromptTest < Minitest::Test
  def setup
    @prompts = Prompt.new
  end

  def test_it_exists
    assert_instance_of Prompt, @prompts
  end

  def test_create_board_prompt
    assert_output(/that be the smallest sea/) {@prompts.create_board}
  end

  def test_show_placement
    assert_output(/Place yer ship on the sea/) {@prompts.show_placement}
  end

  def test_ship_creation_prompt
    assert_output(/ye enter c to/) {@prompts.ship_creation}
  end

  def test_main_menu_prompt
    assert_output(/ARR, welcome to BATTLESHIP/) {@prompts.main_menu}
  end

  def test_create_board_error_prompt
    assert_output(/There be no sea of that size/) {@prompts.create_board_error}
  end

  def test_ship_name_prompt
    assert_output(/Captain, name yer vessel!/) {@prompts.ship_name}
  end

  def test_ship_length_prompt
    assert_output(/Captain, what be the size of yer ship/) {@prompts.ship_length}
  end

  def test_shot_coordinate_prompt
    assert_output(/the cannons are loaded/) {@prompts. shot_coordinate}
  end

  def test_battle_stations_prompt
    assert_output(/Crew, man yer cannons/) {@prompts.battle_stations}
  end
end
