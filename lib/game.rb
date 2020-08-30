require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'

class Game
  def initialize
    @player = Player.new
    @ai_player = Player.new
    @ai_copy_cells = nil
  end


  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp
    if input.downcase == "p"
      game_loop
    elsif input.downcase == "q"
      abort "Okay, bye!"
    else
      puts "Please enter p or q"
      main_menu
    end
  end

  def create_board_prompt
    puts "Before we start how about you choose the size of the battlefield"
    puts "If you want a default board you can enter 4, so choose your size field: "
  end

  def create_boards
    input = gets.chomp.to_i
    if input >= 4 && input <= 26
      @player.board = Board.new(input)
      @ai_player.board = Board.new(input)
      @ai_copy_cells = @ai_player.board.cells.keys
    else
      system('clear')
      puts "Sorry board is to small and dosnt exist in my files please choose a number
              from 4 through 26, Thank you."
      create_boards
    end
  end

  def game_loop
    create_board_prompt
    create_boards
    place_ai_ships
    place_player_ships
    until @player.has_lost? || @ai_player.has_lost?
      display_board
      player_fire_upon
      player_turn_feedback
      break if @ai_player.has_lost?
      sleep(1.5)
      ai_fire_upon
      ai_turn_feedback
      sleep(1.5)
      system('clear')
    end
    winner
    sleep(1.5)
    system('clear')
    main_menu
  end

  def show_placement_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships"
    puts "The Cruiser is three units long and the submarine is two units long"
  end

  def display_board
    puts "=============COMPUTER BOARD============="
    puts @ai_player.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def place_player_ships
    ship_bucket = []
    ship_bucket << Ship.new("Cruiser", 3)
    ship_bucket << Ship.new("Submarine", 2)
    show_placement_prompt
    until ship_bucket.empty?
      puts @player.board.render(true)
      puts "Enter the squares for the #{ship_bucket[0].name} (#{ship_bucket[0].length} spaces):"
      print ">"
      ship_placement = gets.chomp.upcase.split(" ")
      if @player.board.valid_placement?(ship_bucket[0], ship_placement)
        @player.board.place(ship_bucket[0], ship_placement)
        @player.add_ship(ship_bucket.shift)
      else
        puts "Invalid placement. Please try again."
      end
    end
    system('clear')
  end

  def place_ai_ships
    ai_ship_bucket = []
    possible_coordinates = @ai_player.board.cells.keys
    ai_ship_bucket << Ship.new("Cruiser", 3)
    ai_ship_bucket << Ship.new("Submarine", 2)
    until ai_ship_bucket.empty?
      random_coords = possible_coordinates.sample(ai_ship_bucket[0].length).sort
      if @ai_player.board.valid_placement?(ai_ship_bucket[0], random_coords)
        @ai_player.board.place(ai_ship_bucket[0], random_coords)
        random_coords.each do |coord|
          possible_coordinates.delete(coord)
        end
        @ai_player.add_ship(ai_ship_bucket.shift)
      end
    end
  end

  def ai_fire_upon
    random_coords = @ai_copy_cells.sample
    @player.board.cells[random_coords].fire_upon
    @ai_player.last_shot = @player.board.cells[random_coords]
    @ai_copy_cells.delete(random_coords)
  end


  def player_fire_upon
    puts "Enter the coordinate for your shot:"
    print ">"
    target = gets.chomp.upcase
    if @ai_player.board.valid_coordinate?(target) && !@ai_player.board.cells[target].fired_upon?
      @ai_player.board.cells[target].fire_upon
      @player.last_shot = @ai_player.board.cells[target]
    else
      puts "Invalid target, try again"
      player_fire_upon
    end
  end

  def winner
    if @ai_player.has_lost?
      puts "You won!"
    elsif @player.has_lost?
      puts "I won!"
    end
  end

  def player_turn_feedback
    if @player.last_shot.render == "X"
      puts "You sunk my #{@player.last_shot.ship.name}!"
    elsif @player.last_shot.render == "H"
      puts "Your shot on #{@player.last_shot.coordinate} hit!"
    else
      puts "Your shot on #{@player.last_shot.coordinate} was a miss."
    end
  end

  def ai_turn_feedback
    if @ai_player.last_shot.render == "X"
      puts "Ha ha, take that! I sank your #{@ai_player.last_shot.ship.name}!"
    elsif @ai_player.last_shot.render == "H"
      puts "My shot on #{@ai_player.last_shot.coordinate} was a hit!"
    else
      puts "My shot on #{@ai_player.last_shot.coordinate} was a miss."
    end
  end

end
