require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'

class Game
  attr_reader :player, :ai_player
  def initialize
    @player = Player.new
    @ai_player = Player.new
    @ai_copy_cells = nil
    @ai_ship_bucket = []
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp
    if input.downcase == "p"
      create_boards
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
    create_board_prompt
    input = gets.chomp.to_i
    if input >= 4 && input <= 26
      @player.board = Board.new(input)
      @ai_player.board = Board.new(input)
      @ai_copy_cells = @ai_player.board.cells.keys
    else
      system('clear')
      puts "Sorry board is too small and doesn't exist in my files please choose a number
              from 4 through 26, Thank you."
      create_boards
    end
    create_player_ships
  end

  def game_loop
    place_ai_ships
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
    puts "Place your ship on the board"
    puts "Don't make it too easy!"
  end

  def display_board
    puts "=============COMPUTER BOARD============="
    puts @ai_player.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def place_player_ships(ship)
    ship_bucket = []
    @ai_ship_bucket << ship.dup
    ship_bucket << ship
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
    create_player_ships
  end

  def create_player_ships
    puts @player.board.render(true)
    game_starter
    loop do
      puts "Enter the name of the ship you wish to create:"
      print ">"
      ship_name = gets.chomp
      puts "Enter the length of the ship you wish to create:"
      print ">"
      ship_length = gets.chomp.to_i
      if ship_length <= @player.board.board_size && !ship_length.zero?
        ship = Ship.new(ship_name, ship_length)
        puts "Ship created"
        place_player_ships(ship)
      elsif ship_length > @player.board.board_size
        puts "Error: Ship is too large to fit on board"
      elsif ship_length.zero?
        puts "Please enter a length greater than zero in numeric form"
      end
    end
  end

  def game_starter
    puts "If you would like to create ships, press s for (s)hips."
    puts "If you would like to stop creating ships, enter c to (c)ontinue"
    input = gets.chomp.downcase
    if input == "c" && @player.ships.length > 0
      game_loop
    elsif input == "s"
      puts "Let's create a ship Captain!"
    else
      puts "Invalid input."
      game_starter
    end
  end

  def place_ai_ships
    letter_characters = @ai_player.board.letters
    number_characters = @ai_player.board.numbers
    until @ai_ship_bucket.empty?
      switch = rand(0..1)
      if switch == 1
        switch_letter(letter_characters, number_characters)
      elsif switch == 0
        switch_number(letter_characters, number_characters)
      end
    end
  end

  def switch_letter(letters, numbers)
    characters = []
    letters.each_cons(@ai_ship_bucket[0].length) do |group|
      characters << group
    end
    letter_array = characters.sample
    number = numbers.sample
    coords = letter_array.map do |letter|
      letter + number.to_s
    end
    if @ai_player.board.valid_placement?(@ai_ship_bucket[0], coords)
      @ai_player.board.place(@ai_ship_bucket[0], coords)
      @ai_player.add_ship(@ai_ship_bucket.shift)
    end
  end

  def switch_number(letters, numbers)
    characters = []
    numbers.each_cons(@ai_ship_bucket[0].length) do |group|
      characters << group
    end
    number_array  = characters.sample
    letter = letters.sample
    coords = number_array.map do |number|
      letter + number.to_s
    end
    if @ai_player.board.valid_placement?(@ai_ship_bucket[0], coords)
      @ai_player.board.place(@ai_ship_bucket[0], coords)
      @ai_player.add_ship(@ai_ship_bucket.shift)
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
