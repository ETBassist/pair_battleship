require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :player_board, :ai_board

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
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
