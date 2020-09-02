require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/ai'
require './lib/prompt'

class Game
  def initialize
    @player = Player.new
    @ai_player = Player.new
    @ai = AI.new
    @ai_copy_cells = nil
    @prompts = Prompt.new
  end

  def main_menu
    @prompts.main_menu
    input = gets.chomp
    if input.downcase == "p"
      create_boards
    elsif input.downcase == "q"
      abort "Arrr, chicken I sea!"
    else
      puts "Arr, what be ye saying?"
      main_menu
    end
  end

  def create_boards
    @prompts.create_board
    input = gets.chomp.to_i
    if input >= 4 && input <= 26
      @player.board = Board.new(input)
      @ai_player.board = Board.new(input)
      @ai_copy_cells = @ai_player.board.cells.keys
    else
      system('clear')
      @prompts.create_board_error
      create_boards
    end
    create_player_ships
  end

  def game_loop
    @ai.place_ai_ships(@ai_player)
    until @player.has_lost? || @ai_player.has_lost?
      display_board
      player_fire_upon
      player_turn_feedback
      break if @ai_player.has_lost?
      sleep(1.5)
      @ai.ai_fire_upon(@ai_copy_cells, @player.board, @ai_player)
      ai_turn_feedback
      sleep(1.5)
      system('clear')
    end
    winner
    sleep(1.5)
    system('clear')
    main_menu
  end


  def display_board
    puts "=============COMPUTER BOARD============="
    puts @ai_player.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def place_player_ships(ship)
    ship_bucket = []
    @ai.ai_ship_bucket << ship.dup
    ship_bucket << ship
    @prompts.show_placement
    until ship_bucket.empty?
      puts @player.board.render(true)
      puts "Captain, position yer #{ship_bucket[0].name} (#{ship_bucket[0].length} spaces):"
      print ">"
      ship_placement = gets.chomp.upcase.split(" ")
      if @player.board.valid_placement?(ship_bucket[0], ship_placement)
        @player.board.place(ship_bucket[0], ship_placement)
        @player.add_ship(ship_bucket.shift)
      else
        puts "Arrr, that's a lousy place for ye vessel"
      end
    end
    system('clear')
    create_player_ships
  end

  def create_player_ships
    puts @player.board.render(true)
    game_starter
    loop do
      @prompts.ship_name
      ship_name = gets.chomp
      @prompts.ship_length
      ship_length = gets.chomp.to_i
      if ship_length <= @player.board.board_size && !ship_length.zero?
        ship = Ship.new(ship_name, ship_length)
        puts "Vessel created, Captain!"
        place_player_ships(ship)
      elsif ship_length > @player.board.board_size
        puts "Ye vessel be too large, Captain!"
      elsif ship_length.zero?
        puts "Ye vessel be too small, Captain!"
      end
    end
  end

  def game_starter
    @prompts.ship_creation
    input = gets.chomp.downcase
    if input == "c" && @player.ships.length > 0
      @prompts.battle_stations
      sleep(1.5)
      game_loop
    elsif input == "s"
      puts "Let's create a ship Captain!"
    else
      puts "Captain, ye committed to the battle! Choose again!"
      game_starter
    end
  end

  def player_fire_upon
    @prompts.shot_coordinate 
    target = gets.chomp.upcase
    if @ai_player.board.valid_coordinate?(target) && !@ai_player.board.cells[target].fired_upon?
      @ai_player.board.cells[target].fire_upon
      @player.last_shot = @ai_player.board.cells[target]
    else
      puts "That be the wrong place to shoot, Captain!"
      player_fire_upon
    end
  end

  def winner
    if @ai_player.has_lost?
      puts "Ye defeated me! See ye in Davey Jones Locker!"
    elsif @player.has_lost?
      puts "Ye were too weak to be a challenge! Yer ships be my plunder!"
    end
  end

  def player_turn_feedback
    if @player.last_shot.render == "X"
      puts "Me #{@player.last_shot.ship.name} was sunk!"
    elsif @player.last_shot.render == "H"
      puts "Captain, yer shot on #{@player.last_shot.coordinate} hit!"
    else
      puts "Captain, yer shot on #{@player.last_shot.coordinate} was a miss."
    end
  end

  def ai_turn_feedback
    if @ai_player.last_shot.render == "X"
      puts "Ha ha, take that! I sank your #{@ai_player.last_shot.ship.name}!"
    elsif @ai_player.last_shot.render == "H"
      puts "Me shot on #{@ai_player.last_shot.coordinate} was a hit!"
    else
      puts "Avast, my shot on #{@ai_player.last_shot.coordinate} was a miss."
    end
  end
end
