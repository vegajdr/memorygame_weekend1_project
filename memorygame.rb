require "pry"
def game_over?
  false
end

def grid
  cards = [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
  board = ("A".."P").to_a
  grid = board.zip(cards).to_h
  #binding.pry
end

def display_grid
  print grid.keys
end

def choose_card
  gets.chomp.upcase
end

def input_validation
end

def compare_cards grid, card1, card2
  grid[card1] == grid[card2]

end

grid
display_grid

until game_over?
  first_card = choose_card
  second_card = choose_card

  p compare_cards grid, first_card, second_card
  #binding.pry
  #record_match
  #replay
end
