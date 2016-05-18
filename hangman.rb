require "pry"
word_list = ["jason"]
#word_list = IO.readlines('/usr/share/dict/words').delete_if {|x| (x.chomp.length < 6) || (x.chomp.length > 8) || (x.downcase != x)}
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
play_again = ""

def get_word word_db
  word = word_db.sample
  word = word.chomp.split("")
end

def init_board word
  board = ["_"] * word.length
end

def display_info board, guessed, guesses_left
  puts
  puts "Puzzle: " + board * " "
  puts "Previous guesses: " + guessed * " "
  puts "You have #{guesses_left} remaining guesses"
  print "Enter a letter, type 'solve', or type 'hint': "
end

def get_valid_letter guess, guessed
  check = false
  until check
      if ("a".."z").include? guess
        if guessed.include? guess
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
  guess
end

def update_guessed_letter guess, guessed
  guessed.push guess
end

def update_board word, board, guess
  i = 0
  word.each do |s|
    if s == guess
      board[i] = guess
    end
    i += 1
  end
  board
end

def update_guesses_letter board, guess, guesses_left
  if board.include? guess
    guesses_left
  else
    guesses_left -= 1
  end
end

def update_guesses_solve guess, word, guesses_left
  if guess != word * ""
    puts "That is incorrect."
    guesses_left -= 1
  end
  guesses_left
end

def get_valid_solve
  puts "What do you think the word is?"
  guess = gets.chomp
end

def use_hint_and_update hints_left, word, board
  if hints_left > 0
    hint_letters = word - board
    puts "Hint: The letter '#{hint_letters.sample}' is part of the puzzle."
    hints_left -= 1
    puts "You have #{hints_left} hints remaining"
  else
    puts "Sorry, you are out of hints."
  end
  hints_left
end

def fail_condition guesses_left, word
  if guesses_left == 0
    puts
    puts "You have run out of gueeses, Game Over man!"
    puts "The word was #{word * ""}"
    return true
  end
  false
end

def victory_condition board, guess, word
  if ((board.include? "_") == false) || ((guess == word * "") == true)
    puts
    puts "The word IS #{word * ""}. You have won the game, CONGRATULATIONS!"
    return true
  end
  false
end

def play_again_check
  play_again = ""
  until play_again == "n" || play_again == "y"
    puts "Do you want to play again? y or n"
    play_again = gets.chomp
    if play_again != "n" && play_again != "y"
      puts "You must select y (for yes) or n (for no)!"
    end
  end
  play_again
end

def replay? play_again
  if play_again == "n"
    true
  else
    false
  end
end


until replay? play_again
  # looping var init
  done = false
  guesses_left = 6
  hints_left = 2
  alpha_guessed = []

  puts "Welcome to Hangman!"

  word = get_word word_list
  board = init_board word

  until done
    display_info board, alpha_guessed, guesses_left
    guess = gets.chomp

    if (guess != "solve") && (guess != "hint")
      guess = get_valid_letter guess, alpha_guessed
      alpha_guessed = update_guessed_letter guess, alpha_guessed
      board = update_board word, board, guess
      guesses_left = update_guesses_letter board, guess, guesses_left
    elsif guess == "solve"
      guess = get_valid_solve
      guesses_left = update_guesses_solve guess, word, guesses_left
    else
      hints_left = use_hint_and_update hints_left, word, board
    end
    if fail_condition guesses_left, word
      done = true
    elsif victory_condition board, guess, word
      done = true
    end
  end
  play_again = play_again_check
end
