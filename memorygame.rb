require "pry"
def round_over?
  input = gets.chomp
  if input == "quit"
    return true
  end
end


def cards_deck
  cards = [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
end

def grid_create
  cards = cards_deck.shuffle
  board = ("A".."P").to_a
  grid = board.zip(cards).to_h
  #binding.pry
end

def display_grid
  print grid_create.keys
  print grid_create.values
end

def choose_card
  gets.chomp.upcase
end
#correct_guesses

#temporary_guesses
def compare_cards grid, card1, card2
  grid[card1] == grid[card2]

end
#Game
loop do
grid = grid_create
display_grid
binding.pry
  #single round
  loop do
    first_card = choose_card
    second_card = choose_card
    p grid
    p compare_cards grid, first_card, second_card

    #binding.pry
    #record_match
    #replay
    break if round_over?
  end
end
