require 'pry'
require 'colorize'

replay = ""

def symbol_database
  symbols = [
    "Æ", "¥", "£", "þ",
    "¢", "¿", "Ø", "®",
    "§", "¶", "±", "√",
    "π", "∞", "⋰", "Ω",
    "ڲ", "₪", "企", "β",
    "♡", "♊︎", "♐︎", "✖︎",
    "♇", "▷", "☆", "⌘",
    "⎈", "☭", "♢", "♉︎"
  ]
end

def get_dimensions
  dimensions = []
  puts "Lets set up the board!"
  puts
  puts "Enter horizontal dimension for the board(2-8)"
  print "> "
  dim_x = gets.chomp.to_i
  dimensions.push dim_x
  puts "Enter vertical dimension for the board(2-8)"
  print "> "
  dim_y = gets.chomp.to_i
  dimensions.push dim_y

  dimensions
end

def generate_grid dimensions
  grid = (1..(dimensions.first*dimensions.last)).to_a
end

def generate_game_board grid
  board = ["🂠"]*grid.length
  Hash[grid.zip(board)]
end

def random_symbols dimensions, db
  answer = []
  selection = ""

  selection = db.sample(dimensions.inject(:*)/2)
  answer.push(selection).push(selection).flatten!.shuffle

  # answer = [
  #   1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8
  # ]

end

def generate_answer_key answer, grid
  Hash[grid.zip(answer)]
end

def replay? replay
  replay == "n"
end

def replay_check
  puts
  replay = ""
  until replay == "n" || replay == "y"
    puts "Do you want to play again? y or n"
    print "> "
    replay = gets.chomp
    if replay != "n" && replay != "y"
      puts "You must select y (for yes) or n (for no)!"
    end
  end
  replay
end

def game_over? game_board, answer_key, round
  if game_board == answer_key
    puts
    puts "CONGRATULATIONS!  You did it!"
    puts "It took you #{round - 1} rounds, not bad!"
    return true
  else
    return false
  end
end

def display_round round
  puts
  puts "Round #{round}"
end

def display_grid_dynamic board, dimensions
  puts
  puts "key".center(dimensions.first*4.5)
  i = 0
  board.each do |e|
    if (i % dimensions.first == (dimensions.first - 1))
      puts board[i].to_s.center(3)
    else
      print board[i].to_s.center(3)
      print " "
    end
    i += 1
  end
end

def display_board board
  puts
  puts board.values_at("a1", "a2", "a3", "a4").join " "
  puts board.values_at("b1", "b2", "b3", "b4").join " "
  puts board.values_at("c1", "c2", "c3", "c4").join " "
  puts board.values_at("d1", "d2", "d3", "d4").join " "
end

def display_board_dynamic board, grid, dimensions
  puts
    puts "game board".center(dimensions.first*4)
  i = 0
  grid.each do |e|
    if (i % dimensions.first == (dimensions.first - 1))
      puts board.values_at(e).join.center(3)
    else
      print board.values_at(e).join.center(3)
      print " "
    end
    i += 1
  end
end

def choose_cards grid
  puts
  validation = false
  until validation
    pair = []
    print "select your first card or 'quit' to quit > "
    card_1 = gets.chomp
    if card_1 == "quit"
      validation = true
      return card_1
    else
      pair.push card_1
      print "select your second card > "
      card_2 = gets.chomp
      pair.push card_2
      validation = card_validation pair, grid
    end
  end
  pair
end

def card_validation cards, grid
  if (grid.include? cards.first) && (grid.include? cards.last)
    true
  else
    puts "invalid selection, select again"
    false
  end
end

def show_cards board, answer_key, cards, grid
  board[cards.first] = answer_key[cards.first]
  board[cards.last] = answer_key[cards.last]

  display_board_dynamic board, grid
end

def check_for_match board, answer_key, cards
  if answer_key[cards.first] == answer_key[cards.last]
      board[cards.first] = answer_key[cards.first]
      board[cards.last] = answer_key[cards.last]
  end
end

def start_next_round
  puts
  puts "Press [enter] to continue"
  gets
  system "clear"
end

until replay? replay
  round = 1
  puts "Memory Game"
  dimensions = get_dimensions
  grid = generate_grid dimensions
  game_board = generate_game_board grid
  answer_key = generate_answer_key random_symbols(dimensions,symbol_database), grid
  #play game one time
  until game_over? game_board, answer_key, round
    display_round round
    display_board_dynamic game_board, grid, dimensions
    display_grid_dynamic grid, dimensions
    break
    cards = choose_cards grid
    if cards == "quit"
      break
    else
      temp_board = game_board.clone
      show_cards temp_board, answer_key, cards, grid
      check_for_match game_board, answer_key, cards
      round += 1
      start_next_round
    end
  end
  replay = replay_check
end


# refactor using .map
# impliment method that will display any board (array or hash)
# fix displays for new dynamic dimensions - done
# change card slection to choose one card, show updated board, choose second card, show updated board.
# with colorize, add color to flipped cards
# add player 1-2 options, keep score
# play with taking matches off the board
# look at .center
# make a function called symbol_database - done
# change key to grid - done
