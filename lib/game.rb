require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :player_board, :ai_board, :player_ships

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
    @player_ships = []
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
    ship_bucket = []
    ship_bucket << Ship.new("Cruiser", 3)
    ship_bucket << Ship.new("Submarine", 2)
    show_placement_prompt
    until ship_bucket.empty?
      puts @player_board.render(true)
      puts "Enter the squares for the #{ship_bucket[0].name} (#{ship_bucket[0].length} spaces):"
      print ">"
      ship_placement = gets.chomp.split(" ")
      if @player_board.valid_placement?(ship_bucket[0], ship_placement)
        @player_board.place(ship_bucket[0], ship_placement)
        @player_ships << ship_bucket.shift
      else
        puts "Invalid placement. Please try again."
      end
    end
  end

end
