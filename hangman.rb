require "pry"

word_list = IO.readlines('/usr/share/dict/words').delete_if {|x| (x.chomp.length < 6) || (x.chomp.length > 8) || (x.downcase != x)}
# File.open('') do |f|
#   f.each_line do |line|
#     word_list.push line.chomp.downcase.split("")
#   end
# end

# non looping var init
word = []
board = []
guess = ""
replay = false
hint_letters = []


until replay
  # looping var init
  done = false
  guesses_left = 6
  hints_left = 2
  alpha_guessed = []
  play_again = ""

  puts "Welcome to Hangman!"
  word = word_list[rand(0...(word_list.length))]
  #word = word_list.sample
  word = word.chomp.split("")
  board = ["_"] * word.length
  until done
    puts
    puts "Puzzle: " + board * " "
    puts "Previous guesses: " + alpha_guessed * " "
    puts "You have #{guesses_left} remaining guesses"
    print "Enter a letter, type 'solve', or type 'hint': "
    guess = gets.chomp
    if (guess != "solve") && (guess != "hint")
      check = false
      until check
        if ("a".."z").include? guess
          if alpha_guessed.include? guess
            print "You already guessed that letter, select another: "
            guess = gets.chomp
          else
            check = true
          end
        else
          print "You entered an invalid letter, try again: "
          guess = gets.chomp
        end
      end
      alpha_guessed.push guess
      i = 0
      word.each do |s|
        if s == guess
          board[i] = guess
        end
        i += 1
      end
      if board.include? guess
        guesses_left
      else
        guesses_left -= 1
      end
    elsif guess == "solve"
      puts "What do you think the word is?"
      guess = gets.chomp
      if guess != word * ""
        puts "That is incorrect."
        guesses_left -= 1
      end
    else
      if hints_left > 0
        hint_letters = word - board
        puts "Hint: The letter '#{hint_letters[rand]}' is part of the puzzle."
        hints_left -= 1
        puts "You have #{hints_left} hints remaining"
        #binding.pry
      else
        puts "Sorry, you are out of hints."
      end

    end
      if guesses_left == 0
        puts
        puts "You have run out of gueeses, Game Over man!"
        puts "The word was #{word * ""}"
        done = true
      end
      if ((board.include? "_") == false) || ((guess == word * "") == true)
        puts
        puts "The word IS #{word * ""}. You have won the game, CONGRATULATIONS!"
        done = true
      end
  end
  until play_again == "n" || play_again == "y"
    puts "Do you want to play again? y or n"
    play_again = gets.chomp
    if play_again != "n" && play_again != "y"
      puts "You must select y (for yes) or n (for no)!"
    end
  end
  if play_again == "n"
    replay = true
  end
end
