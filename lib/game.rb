require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :player_board, :ai_board, :player_ships 

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
    @ai_ships = []
    @player_ships = []
    @ai_copy_cells = @ai_board.cells.keys
    @player_shot_result = nil
    @ai_shot_result = nil
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

  def game_loop
    place_ai_ships
    place_player_ships
    until player_won? || ai_won?
      display_board
      player_fire_upon
      player_turn_feedback
      break if player_won?
      sleep(1.5)
      ai_fire_upon
      ai_turn_feedback
      sleep(1.5)
      system('clear')
    end
    winner
    sleep(1.5)
    main_menu
  end

  def show_placement_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships"
    puts "The Cruiser is three units long and the submarine is two units long"
  end

  def display_board
    puts "=============COMPUTER BOARD============="
    puts @ai_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def place_player_ships
    ship_bucket = []
    ship_bucket << Ship.new("Cruiser", 3)
    ship_bucket << Ship.new("Submarine", 2)
    show_placement_prompt
    until ship_bucket.empty?
      puts @player_board.render(true)
      puts "Enter the squares for the #{ship_bucket[0].name} (#{ship_bucket[0].length} spaces):"
      print ">"
      ship_placement = gets.chomp.upcase.split(" ")
      if @player_board.valid_placement?(ship_bucket[0], ship_placement)
        @player_board.place(ship_bucket[0], ship_placement)
        @player_ships << ship_bucket.shift
      else
        puts "Invalid placement. Please try again."
      end
    end
    system('clear')
  end

  def place_ai_ships
    ai_ship_bucket = []
    possible_coordinates = @ai_board.cells.keys
    ai_ship_bucket << Ship.new("Cruiser", 3)
    ai_ship_bucket << Ship.new("Submarine", 2)
    until ai_ship_bucket.empty?
      random_coords = possible_coordinates.sample(ai_ship_bucket[0].length).sort
      if @ai_board.valid_placement?(ai_ship_bucket[0], random_coords)
        @ai_board.place(ai_ship_bucket[0], random_coords)
        random_coords.each do |coord|
          possible_coordinates.delete(coord)
        end
        @ai_ships << ai_ship_bucket.shift
      end
    end
  end

  def ai_fire_upon
    random_coords = @ai_copy_cells.sample
    @player_board.cells[random_coords].fire_upon
    @ai_shot_result = @player_board.cells[random_coords]
    @ai_copy_cells.delete(random_coords)
  end

  def player_won?
    @ai_ships.all? do |ship|
      ship.health == 0
    end
  end

  def ai_won?
    @player_ships.all? do |ship|
      ship.health == 0
    end
  end

  def player_fire_upon
    puts "Enter the coordinate for your shot:"
    print ">"
    target = gets.chomp.upcase
    if @ai_board.valid_coordinate?(target) && !@ai_board.cells[target].fired_upon?
      @ai_board.cells[target].fire_upon
      @player_shot_result = @ai_board.cells[target]
    else
      puts "Invalid target, try again"
      player_fire_upon
    end
  end

  def winner
    if player_won?
      puts "You won!"
    elsif ai_won?
      puts "I won!"
    end
  end

  def player_turn_feedback
    if @player_shot_result.render == "X"
      puts "You sunk my #{@player_shot_result.ship.name}!"
    elsif @player_shot_result.render == "H"
      puts "Your shot on #{@player_shot_result.coordinate} hit!"
    else
      puts "Your shot on #{@player_shot_result.coordinate} was a miss."
    end
  end

  def ai_turn_feedback
    if @ai_shot_result.render == "X"
      puts "Ha ha, take that! I sank your #{@ai_shot_result.ship.name}!"
    elsif @ai_shot_result.render == "H"
      puts "My shot on #{@ai_shot_result.coordinate} was a hit!"
    else
      puts "My shot on #{@ai_shot_result.coordinate} was a miss."
    end
  end

end
