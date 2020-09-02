require './test/test_helper'
require 'mocha/minitest'
require 'stringio'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @player = Board.new
    @ai_player = Board.new
    @ship = Ship.new("Tuggy", 1)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_should_return_prompts_for_creating_board
    assert_output(/Before we start how about you choose the size of the battlefield/) { @game.create_board_prompt}
    assert_output(/If you want a default board you can enter 4, so choose your size field: /) { @game.create_board_prompt}
  end

  def test_should_return_prompts_for_show_placement
    assert_output(/Place your ship on the board/) { @game.show_placement_prompt}
    assert_output(/Don't make it too easy!/) { @game.show_placement_prompt}
  end

  def test_should_return_prompt_depending_who_lost
    @game.player.add_ship(@ship)
    assert_output(/You won!/) { @game.winner}
    @game.player.ships.shift
    @game.ai_player.add_ship(@ship)
    assert_output(/I won!/) { @game.winner}
  end

  def test_should_return_output_depending_input_game_starter
    skip
    @game.player.add_ship(@ship)

    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @game.stub :game_loop, mocked_method do
      @game.game_starter
    end

    assert_output(/Let's create a ship Captain!/) { @game.game_starter}

    mocked_method2 = MiniTest::Mock.new
    mocked_method2.expect(:call,nil)
    @game.stub :game_starter, mocked_method2 do
      @game.game_starter
    end
  end

  def test_should_return_methods_depending_on_input_in_main_menu
    skip
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @game.stub :create_boards, mocked_method do
      @game.main_menu
    end

    mocked_method2 = MiniTest::Mock.new
    mocked_method2.expect(:call,nil)
    @game.stub :main_menu, mocked_method2 do
      @game.main_menu
    end
  end

  def test_should_call_method_depending_on_input_in_create_boards
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @game.stub :create_player_ships, mocked_method do
      @game.create_boards
    end

    mocked_method2 = MiniTest::Mock.new
    mocked_method2.expect(:call,nil)
    @game.stub :create_boards, mocked_method2 do
      @game.create_boards
    end
  end
end
