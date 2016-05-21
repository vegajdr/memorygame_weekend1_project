require "pry"
## CHANGE THIS METHOD
def round_over? permanent_grid, secret_grid#If all cards are guessed
  permanent_grid == secret_grid
end
#----------------------

def cards_deck
  cards = [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
end

def master_grid_create
  cards = cards_deck.shuffle
  board = ("A".."P").to_a
  grid = board.zip(cards).to_h
  #binding.pry
end

def answer_grid_create
  hash = {}
  ("A".."P").to_a.each do | i |
    hash[i] = " "
  end
  return hash
end

def add_permanent_answers first_card, second_card, match, p_grid, s_grid
  if match
    p_grid[first_card] = s_grid [first_card]
    p_grid[second_card] = s_grid [second_card]

  end

end

def display_grid grid
  puts "|" + grid.keys.join("| |") + "|"
  puts " " + grid.values.join("   ") + ""
end

def clear_answers_grid answers_grid, match
  unless match
    answers_grid.each { |key, value| answers_grid[key] = nil}
  end

end

def choose_card card = nil
  input = gets.chomp.upcase
  until ("A" .. "P").to_a.include?(input) || input != ""
    puts "Enter a valid letter (A to P)"
    input = gets.chomp.upcase
  end
  until card != input
    puts "You already selected this card. Please select another one"
    input = gets.chomp.upcase
  end
  return input
end

def compare_cards grid, card1, card2
  grid[card1] == grid[card2]

end

def answers_display grid, match, answers_grid
  if match
    answers_grid[choose_card] = grid[choose_card]
  end
end

def answer_record card, secret_grid, answer_grid
  card =
  answer_grid[card] = secret_grid[card]
  return answer_grid
end

game_over = false
#Game
loop do
  secret_grid = master_grid_create
  answers_grid = answer_grid_create
  permanent_grid = answer_grid_create
  temporary_grid = answer_grid_create
  # puts "You have 5 seconds to memorize this deck"
  display_grid secret_grid
  # sleep 1
  # system "clear"
  #
#PERMANENT  PLUS  INPUT
  #binding.pry
  #display_grid
  #single round
  loop do
    puts "Choose location for first card:"
    first_card = choose_card
    answer_record first_card, secret_grid, temporary_grid
    puts "Temporary:"
    display_grid temporary_grid

    puts "Choose location for second card:"
    second_card = choose_card first_card


    answer_record second_card, secret_grid, temporary_grid
    puts "Temporary"
    display_grid temporary_grid
    ###Pay attention to location


    match = compare_cards secret_grid, first_card, second_card

    add_permanent_answers first_card, second_card, match, permanent_grid, secret_grid
    #clear_answers_grid temporary_grid, match
    #-----------------
    puts "Secret"
    display_grid secret_grid
    puts "Permanent"
    display_grid permanent_grid

    puts "Result of comparison: #{match}" if match
    #answers_display secret_grid, match, answers_grid
    ## IF match is true then answers_grid gets cleared
    #binding.pry
    #record_match
    #replay
    break if round_over? permanent_grid, secret_grid
  end
  break if game_over
end
