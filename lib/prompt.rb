class Prompt
  def create_board
    puts "Before we set sail, Captain, what be the size of yer battlefield"
    puts "If ye choose 4, that be the smallest sea. So choose yer size sea: "
  end

  def show_placement
    puts "Place yer ship on the sea"
    puts "Don't make it too easy to find!"
  end

  def ship_creation
    puts "Captain, if ye like to create a ship, ye press s for (s)hips."
    puts "Or if ye be ready for battle, ye enter c to (c)ontinue"
  end

  def main_menu
    puts "ARR, welcome to BATTLESHIP"
    puts "Enter p for yer demise. Enter q to run away, ye yellow bellied landblubber!"
  end

  def create_board_error
    puts "There be no sea of that size! A tip for ye: pick yer sea
            from 4 through 26, or arrr you afraid?"
  end

  def ship_name
    puts "Captain, name yer vessel!" 
    print ">"
  end

  def ship_length
    puts "Captain, what be the size of yer ship?" 
    print ">"
  end

  def shot_coordinate
    puts "Captain, the cannons are loaded! We're ready for yer command!" 
    print ">"
  end

  def battle_stations
    puts "Crew, man yer cannons! Lift yer swords!"
    puts "And most importantly, loot them clean!"
  end
end
