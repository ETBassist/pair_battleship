require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :player_board, :ai_board, :player_ships

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
    @player_ships = []
    create_player_ships
    @ship_bucket = @player_ships
  end

  def create_player_ships
    @player_ships << Ship.new("Cruiser", 3)
    @player_ships << Ship.new("Submarine", 2)
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp
    if input.downcase == "p"
      # go to method that starts game
    elsif input.downcase == "q"
      abort "Okay, bye!"
    else
      puts "Please enter p or q"
      main_menu
    end
  end

  def show_placement_prompt
    puts "I have laid outs my ships on the grid."
    puts "You now need to lay out your two ships"
    puts "The Cruiser is three units long and the submarine is two units long"
  end

  def place_player_ships
    @ship_bucket.each do |ship|
      puts @player_board.render(true)
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      print ">"
      ship_placement = gets.chomp.split(" ")
      if @player_board.valid_placement?(ship, ship_placement)
        @player_board.place(ship, ship_placement)
        @ship_bucket.shift
        place_player_ships if @ship_bucket.length > 0
      else
        puts "Invalid placement. Please try again."
        place_player_ships
      end
    end
  end

end
