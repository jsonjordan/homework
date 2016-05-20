require "pry"
replay = ""

# look at .center

# key = [
#   "a1", "a2", "a3", "a4",
#   "b1", "b2", "b3", "b4",
#   "c1", "c2", "c3", "c4",
#   "d1", "d2", "d3", "d4"
# ]

def get_dimensions
  dimensions = []
  puts "enter horizontal dimension for board"
  dim_x = gets.chomp.to_i
  dimensions.push dim_x
  puts "enter vertical dimension for board"
  dim_y = gets.chomp.to_i
  dimensions.push dim_y

  dimensions
end

def generate_key dimensions
  key = (1..(dimensions.first*dimensions.last)).to_a
end

def init_game_board key
  board = ["🂠"]*key.length
  Hash[key.zip(board)]
end

def init_answer_board
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

  # answer = [
  #   "Æ", "¥", "£", "þ",
  #   "¢", "¿", "Æ", "Ø",
  #   "þ", "£", "¢", "¿",
  #   "¥", "Ø", "®", "®"
  # ]
  answer = [
    1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8
  ]
  #
  # answer.shuffle
end

def init_answer_key answer, key
  Hash[key.zip(answer)]
end

def replay? replay
  replay == "n"
end

def replay_check
  replay = ""
  until replay == "n" || replay == "y"
    puts "Do you want to play again? y or n"
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

def display_key board
  puts
  puts "    key"
  puts board.values_at(0,1,2,3).join " "
  puts board.values_at(4,5,6,7).join " "
  puts board.values_at(8,9,10,11).join " "
  puts board.values_at(12,13,14,15).join " "
end

def display_board board
  puts
  puts board.values_at("a1", "a2", "a3", "a4").join " "
  puts board.values_at("b1", "b2", "b3", "b4").join " "
  puts board.values_at("c1", "c2", "c3", "c4").join " "
  puts board.values_at("d1", "d2", "d3", "d4").join " "
end

def display_board_dynamic board, key
  puts
  i = 0
  key.each do |e|
    if (i % 4 == 3)
      puts board.values_at(e).join""
    else
      print board.values_at(e).join""
      print " "
    end
    i += 1
  end
end

def choose_cards key
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
      validation = card_validation pair, key
    end
  end
  pair
end

def card_validation cards, key
  if (key.include? cards.first) && (key.include? cards.last)
    true
  else
    puts "invalid selection, select again"
    false
  end
end

def show_cards board, answer_key, cards, key
  board[cards.first] = answer_key[cards.first]
  board[cards.last] = answer_key[cards.last]

  display_board_dynamic board, key
end

def check_match board, answer_key, cards
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
  key = generate_key get_dimensions
  game_board = init_game_board key
  answer = init_answer_board
  answer_key = init_answer_key answer, key
binding.pry

  #play game one time
  until game_over? game_board, answer_key, round
    display_round round
    display_board_dynamic game_board, key
    display_key key
    cards = choose_cards key
    if cards == "quit"
      break
    else
      temp_board = game_board.clone
      show_cards temp_board, answer_key, cards, key
      check_match game_board, answer_key, cards
      round += 1
      start_next_round
    end
  end
  replay = replay_check
end


# refactor using .map
# impliment method that will display any board (array or hash)
# make board size dynamic (from 2x2 up)
    # - auto generate key (see generated_key.rb)
    # - auto generate game_board  my_array = ["░"] * board_elements
    # - auto generate answer_board  symbols_array.select push in twice till full
      # - no repeats!
# allow user to select both dimensions
