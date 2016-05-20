require "pry"

accepted_words = File.open('sowpods.txt').to_a

word = nil
current_player = 1
round = 1

def scrabble_points
  {
      "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1, "l" => 1, "n" => 1, "s" => 1, "t" => 1, "r" => 1,
      "d" => 2, "g" => 2,
      "b" => 3, "c" => 3, "m" => 3, "p" => 3,
      "f" => 4, "h" => 4, "v" => 4, "w" => 4, "y" => 4,
      "k" => 5,
      "j" => 8, "x" => 8,
      "q" => 10, "z" => 10
    }
end

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
  until word.to_i.to_s != word
    if word.to_i.to_s == word
      print "You must enter a WORD, try again: "
      word = gets.chomp
      puts
    end
  end
  word
end

def word_acceptance_check word, db
  check = false
  until check
    db.each do |a|
      if a.chomp.downcase == word
        check = true
      end
    end
    if check == false
      print "That is not a valid Scrabble word, try again: "
      word = gets.chomp
      word = word_validation_check word
      puts
    end
  end
  word
end

def calc_score word
  score = 0
  word.split("").each do |s|
    score += scrabble_points[s]
  end
  score
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

def display_current_score word, score
  puts "'#{word}' is worth #{score} points"
end

def display_updtated_scores totals, maxes
  i = 0
  totals.each do |total|
    puts "Player #{i} - Total: #{total}  Max: #{maxes[i]}"
    i += 1
  end
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
  display_updtated_scores totals, maxes
end


puts "Welcome to the Scrabble Score Keeper!"
puts
players = setup_players
totals = setup_totals players
maxes = setup_maxes players

until word.to_i == -1
  score = 0
  puts
  print "Player #{current_player}, enter your word or type '-1' to quit: "
  word = gets.chomp
  puts

  unless word.to_i == -1
    word = word_validation_check word
    word = word_acceptance_check word, accepted_words

    score = calc_score word

    totals = update_totals totals, current_player, score
    maxes = update_maxes maxes, current_player, score

    display_current_score word, score

    if current_player == players
      puts
      puts "Current scores after Round #{round}"
      display_updtated_scores totals, maxes
      round += 1
    end

    current_player = increment_player current_player, players
  end
end

final_scores totals, maxes
