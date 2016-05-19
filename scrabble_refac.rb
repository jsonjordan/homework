require "pry"

word = nil
current_player = 1

def setup_players
  print "How many players? "
  players = gets.chomp.to_i
end

def setup_totals players
  totals = []
  players.times do
    totals.push 0
  end
  totals
end

def setup_maxes players
  maxes = []
  players.times do
    maxes.push 0
  end
  maxes
end

def word_validation_check word
  word = gets.chomp
  until (word.to_i.to_s != word) || (word == "-1")
    if word.to_i.to_s == word
      puts "You must enter a word or enter '-1' to quit"
      word = gets.chomp
    end
  end
  word
end

def calc_score word
  #do stuff
  10
end

def update_totals totals, current_player, score
  totals[current_player - 1] += score
  totals
end

def update_maxes maxes, current_player, score
  if score > maxes[current_player - 1]
    maxes[current_player - 1] = score
  end
  maxes
end

def increment_player current_player, players
  current_player += 1
  if current_player > players
    current_player = 1
  end
  current_player
end

def final_scores totals, maxes
  puts "Final scores:"
  i = 1
  totals.each do |total|
    puts "Player #{i} - Total: #{total}  Max: #{maxes[i-1]}"
    i += 1
  end
end


puts "Welcome to the Scrabble Score Keeper!"
players = setup_players
totals = setup_totals players
maxes = setup_maxes players

until word.to_i == -1
  score = nil
  print "Player #{current_player}, enter your word or type '-1' to quit: "
  word = word_validation_check word
  unless word.to_i == -1
    score = calc_score word

    totals = update_totals totals, current_player, score
    maxes = update_maxes maxes, current_player, score

    current_player = increment_player current_player, players
  end
end

final_scores totals, maxes
