require "pry"
## CHANGE THIS METHOD
def round_over? permanent_grid, secret_grid#If all cards are guessed
  permanent_grid == secret_grid
end
#----------------------

def cards_deck
  cards = [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
  
  # cards = ["§","¶","±","√",
  # "π", "∞", "⋰", "Ω",
  # "§", "¶", "±", "√",
  # "π", "∞", "⋰", "Ω",]

end

def master_grid_create
  cards = cards_deck.shuffle
  board = ("A".upto "P").to_a
  grid = board.zip(cards).to_h
  #binding.pry
end

def answer_grid_create
  hash = {}
  master_grid_create.keys.to_a.each do | i |
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
  puts "---------------------------------------------------------------"
end

def clear_answers_grid answers_grid, match, grid_comparison
  unless match
    answers_grid.each do |key, value| 
      if grid_comparison[key] != answers_grid[key]
        answers_grid[key] = " "
      end
    end
  end

end

def choose_card card = nil
  input = gets.chomp.upcase
  until (("A".upto "P").to_a.include?(input)) || (input != "")
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

loop do # New Game start (shuffled deck)
  secret_grid = master_grid_create
  answers_grid = answer_grid_create
  permanent_grid = answer_grid_create
  temporary_grid = answer_grid_create
  # puts "You have 5 seconds to memorize this deck"
  display_grid secret_grid
  # sleep 1
  # system "clear"
  #

  loop do # Single round
    puts "Choose location for first card:"
    first_card = choose_card
    answer_record first_card, secret_grid, temporary_grid
    puts "First Card:"
    display_grid temporary_grid

    puts "Choose location for second card:"
    second_card = choose_card first_card


    answer_record second_card, secret_grid, temporary_grid
    puts "Second Card:"
    display_grid temporary_grid
    ###Pay attention to location


    match = compare_cards secret_grid, first_card, second_card

    add_permanent_answers first_card, second_card, match, permanent_grid, secret_grid
    clear_answers_grid temporary_grid, match, permanent_grid
    #-----------------
    sleep 3
    system "clear"
    
    puts "Correct Answers:"
    display_grid permanent_grid

    puts "Result of comparison: #{match}" if match
    
    break if round_over? permanent_grid, secret_grid
  end
  break if game_over
end
