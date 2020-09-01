class AI
  attr_accessor :ai_ship_bucket

  def initialize
    @ai_ship_bucket = []
  end
  
  def place_ai_ships(player)
    letter_characters = player.board.letters
    number_characters = player.board.numbers
    until @ai_ship_bucket.empty?
      switch = rand(0..1)
      if switch == 1
        generate_coords(letter_characters, number_characters, player)
      elsif switch == 0
        generate_coords(number_characters, letter_characters, player)
      end
    end
  end

  def generate_coords(array1, array2, player)
    characters = []
    array1.each_cons(@ai_ship_bucket[0].length) do |group| 
      characters << group
    end
    character_group = characters.sample
    single_character = array2.sample 
    coords = character_group.map do |character|
      if single_character.to_i.zero?
        single_character + character.to_s
      else
        character.to_s + single_character
      end
    end
    if player.board.valid_placement?(@ai_ship_bucket[0], coords)
      player.board.place(@ai_ship_bucket[0], coords)
      player.add_ship(@ai_ship_bucket.shift)
    end
  end

  def ai_fire_upon(possible_targets, target_board)
    random_coords = possible_targets.sample
    @player.board.cells[random_coords].fire_upon
    @ai_player.last_shot = @player.board.cells[random_coords]
    possible_targets.delete(random_coords)
  end


end
