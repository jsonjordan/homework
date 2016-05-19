require "pry"

key = [
  "a1", "a2", "a3", "a4",
  "b1", "b2", "b3", "b4",
  "c1", "c2", "c3", "c4",
  "d1", "d2", "d3", "d4"
]

def init_board key
  board = [
    "░", "░", "░", "░",
    "░", "░", "░", "░",
    "░", "░", "░", "░",
    "░", "░", "░", "░"
  ]
  Hash[key.zip(board)]
end

def init_answer_board
  answer = [
    "Æ", "¥", "£", "þ",
    "¢", "¿", "Æ", "Ø",
    "þ", "£", "¢", "¿",
    "¥", "Ø", "®", "®"
  ]
  answer.shuffle
end

def init_answerkey_hash answer, key
  Hash[key.zip(answer)]
end

def player_wants_to_quit
  false
end

def game_over
  #victory condition
  false
end

def display_key board
  [0,4,8,12].each do |start|
    stop = start + 3
    start.upto stop do |i|
      print "#{board[i]} "
    end
    puts
  end
end

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

def display_temp_board temp_board, answer_key, cards
  temp_board[cards.first] = answer_key[cards.first]
  temp_board[cards.last] = answer_key[cards.last]

  display_game_board temp_board
  puts
end

def check_match board, answer_key, cards
  if answer_key[cards.first] == answer_key[cards.last]
      board[cards.first] = answer_key[cards.first]
      board[cards.last] = answer_key[cards.last]
  end
end

game_board = init_board key
answer = init_answer_board
ultimate = init_answerkey_hash answer, key


until player_wants_to_quit
  #play game one time
  until game_over
    display_game_board game_board
    puts
    puts "    key"
    display_key key
    cards = choose_cards
    temp_board = game_board.clone
    display_temp_board temp_board, ultimate, cards
    check_match game_board, ultimate, cards
    puts "Press [enter] to continue"
    gets
    system "clear"
  end
end
