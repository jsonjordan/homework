require "pry"

key = [
  "a1", "a2", "a3", "a4",
  "b1", "b2", "b3", "b4",
  "c1", "c2", "c3", "c4",
  "d1", "d2", "d3", "d4"
]

def init_game_board key
  board = [
    "░", "░", "░", "░",
    "░", "░", "░", "░",
    "░", "░", "░", "░",
    "░", "░", "░", "░"
  ]
  Hash[key.zip(board)]
end

def init_answer_board
  # answer = [
  #   "Æ", "¥", "£", "þ",
  #   "¢", "¿", "Æ", "Ø",
  #   "þ", "£", "¢", "¿",
  #   "¥", "Ø", "®", "®"
  # ]
  answer = [
    1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8
  ]

  #answer.shuffle
end

def init_answer_key answer, key
  Hash[key.zip(answer)]
end

def player_wants_to_quit
  false
end

def game_over? game_board, answer_key
  if game_board == answer_key
    puts "CONGRATULATIONS!  You did it!"
    return true
  else
    return false
  end
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
  puts board.values_at("a1", "a2", "a3", "a4").join " "
  puts board.values_at("b1", "b2", "b3", "b4").join " "
  puts board.values_at("c1", "c2", "c3", "c4").join " "
  puts board.values_at("d1", "d2", "d3", "d4").join " "
end

def choose_cards
  puts
  pair = []
  print "select your first card: "
  card_1 = gets.chomp
  pair.push card_1

  print "select your second card: "
  card_2 = gets.chomp
  pair.push card_2

  pair
end

def display_temp_board board, answer_key, cards
  board[cards.first] = answer_key[cards.first]
  board[cards.last] = answer_key[cards.last]

  display_board board
  puts
end

def check_match board, answer_key, cards
  if answer_key[cards.first] == answer_key[cards.last]
      board[cards.first] = answer_key[cards.first]
      board[cards.last] = answer_key[cards.last]
  end
end

until player_wants_to_quit
  game_board = init_game_board key
  answer = init_answer_board
  answer_key = init_answer_key answer, key


  #play game one time
  until game_over? game_board, answer_key
    display_board game_board
    display_key key
    cards = choose_cards
    temp_board = game_board.clone
    display_temp_board temp_board, answer_key, cards
    check_match game_board, answer_key, cards
    puts "Press [enter] to continue"
    gets
    system "clear"
  end
  puts
  puts "Would you like to play again?"
end
