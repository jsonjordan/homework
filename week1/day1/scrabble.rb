require "pry"

puts "Welcome to the Scrabble Score Keeper!"
# puts "1 or 2 players?"
# players = gets.to_i

total_1 = 0
total_2 = 0
max_1 = 0
max_2 = 0
currentPlayer = 0
players = 0

until players == 1 || players == 2
  puts "1 or 2 players?"
  players = gets.to_i
  if players > 2
    puts "You must select 1 or 2!"
  end
end


if players == 1
  puts "Enter your score or type 'quit' to quit:"
  input = gets.chomp
  if input == "quit"

  else
    until input == "quit"
      score = input.to_i
      if input != input.to_i.to_s
        puts "Please enter a vailid number."
      elsif input == input.to_i.to_s
        total_1 = total_1 + score
        if score > max_1
          max_1 = score
        end
        puts "Total: #{total_1}"
        puts "Max: #{max_1}"
      end
      puts "Enter your score or type 'quit' to quit:"
      input = gets.chomp

    end
  end
  f = File.open "scores.txt", "w"

  f.puts "Total: #{total_1}"
  f.puts "Max: #{max_1}"

  f.close

elsif players == 2
  currentPlayer = 1
  puts "Player 1 - Enter your score or type 'quit' to quit:"
  input = gets.chomp
  if input == "quit"

  else
    until input == "quit"
      score = input.to_i
      if input != input.to_i.to_s
        puts "Please enter a vailid number."
      elsif input == input.to_i.to_s
        if currentPlayer == 1
          total_1 = total_1 + score
          if score > max_1
            max_1 = score
          end
          puts "Player 1 Total: #{total_1}"
          puts "Player 1 Max: #{max_1}"
          currentPlayer = 2

        elsif currentPlayer == 2
          total_2 = total_2 + score
          if score > max_2
            max_2 = score
          end
          puts "Player 2 Total: #{total_2}"
          puts "Player 2 Max: #{max_2}"
          currentPlayer = 1

        end
      end
      puts "Player " + currentPlayer.to_s + " - Enter your score or type 'quit' to quit:"
      input = gets.chomp
    end
  end

  f = File.open "scores.txt", "w"

  f.puts "Player 1 Total: #{total_1}"
  f.puts "Player 1 Max: #{max_1}"
  f.puts "Player 2 Total: #{total_2}"
  f.puts "Player 2 Max: #{max_2}"

  f.close


end
