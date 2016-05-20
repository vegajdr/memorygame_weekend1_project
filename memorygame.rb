require "pry"
def game_over?
  false
end

def reshuffle cards
  cards.shuffle!
end

def cards_deck
  cards = [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
  reshuffle cards
end

def grid
  cards = cards_deck
  board = ("A".."P").to_a
  grid = board.zip(cards).to_h
end

def display_grid
  print grid.keys
  print grid.values
end

def choose_card
  gets.chomp.upcase

end



#correct_guesses

#temporary_guesses


def compare_cards grid, card1, card2
  binding.pry
  grid[card1] == grid[card2]

end

grid
new_deck = reshuffle cards_deck
display_grid


until game_over?
  first_card = choose_card
  second_card = choose_card
  p compare_cards grid, first_card, second_card

  #binding.pry
  #record_match
  #replay
end
