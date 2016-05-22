require "pry"
require "rubycards"
include RubyCards



#binding.pry
## CHANGE THIS METHOD
def round_over? permanent_grid, secret_grid#If all cards are guessed
  over = false
  if permanent_grid == secret_grid
    sleep 3
    system "clear"
    puts "You have WON!"
    over = true
  end
  over
end
#----------------------

def difficulty
  #return a hash
  puts "Please type 'easy', 'medium' or 'hard' to set your difficulty"
  hash = {}
  input = gets.chomp 
  if input.downcase == "easy"
    
    hash["D"] = 2
  elsif input.downcase == "medium"
    hash["H"] = 4
  elsif input.downcase == "hard"
    hash["P"] = 8
  end
  hash
  
end

# mode = difficulty
#binding.pry

def cards_deck mode
  cards = []
  
  (1..mode.values.first).to_a.each do | n |
    cards.push n
  end
  
  (1..mode.values.first).to_a.each do | n |
    cards.push n
  end
    #cards.push
  
  
  # hand1 = Hand.new
  # deck1 = Deck.new

  # hand2 = Hand.new
  # deck2 = Deck.new

  # hand1.draw(deck1, 5)
  # hand2.draw(deck2, 5)
  
  # hand1.each do | i |
  #   cards.push i
  #end
    
  return cards.shuffle
end

def master_grid_create mode
  cards = cards_deck mode
  board = ("A".upto mode.keys.first).to_a
  grid = board.zip(cards).to_h
  #binding.pry
end

def answer_grid_create secret_grid
  hash = {}
  secret_grid.keys.to_a.each do | i |
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

def choose_card card = nil, mode
  input = gets.chomp.upcase
  until ("A".upto mode.keys.first).to_a.include?(input)
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
  mode = difficulty
  secret_grid = master_grid_create mode
  answers_grid = answer_grid_create secret_grid
  permanent_grid = answer_grid_create secret_grid
  temporary_grid = answer_grid_create secret_grid
  # puts "You have 5 seconds to memorize this deck"
  display_grid secret_grid
  # sleep 1
  # system "clear"
  #

  loop do # Single round
    puts "Choose location for first card:"
    first_card = choose_card mode
    answer_record first_card, secret_grid, temporary_grid
    puts "First Card:"
    display_grid temporary_grid

    puts "Choose location for second card:"
    second_card = choose_card first_card, mode


    answer_record second_card, secret_grid, temporary_grid
    puts "Second Card:"
    display_grid temporary_grid
    ###Pay attention to location


    match = compare_cards secret_grid, first_card, second_card

    add_permanent_answers first_card, second_card, match, permanent_grid, secret_grid
    clear_answers_grid temporary_grid, match, permanent_grid
    #-----------------
    sleep 1
    system "clear"
    
    puts "Correct Answers:"
    display_grid permanent_grid

    puts "Result of comparison: #{match}" if match
    
    break if round_over? permanent_grid, secret_grid
  end
  break if game_over
end
