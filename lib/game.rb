require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board_1, :board_2

  def initialize
    @board_1 = Board.new
    @board_2 = Board.new
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


end
