require 'yaml'

class Game
    @@filename = 'abel.yaml'
    @@turns = 11
    @@target_word = 'better'
    @@target_array = []
    @@player_picks = []
    @@guess_word = []

    def get_letter
        puts "Progress: #{@@guess_word.join()}"
        puts "Letters chosen so far: #{@@player_picks.join()}"
        puts "Guess a letter, or press 1 to save game"
        letter = gets.strip.downcase
        if letter.to_s == '1'
            save_game
        end
        until letter.length == 1 && letter.match?(/[[:alpha:]]/)
            puts "Invalid input. Try again."
            letter = gets.strip.downcase
        end

        while @@player_picks.include? letter
            puts "Letter has already been chosen. Try again"
            letter = gets.strip.downcase
        end

        @@player_picks.push(letter)
        return letter
    end

    def save_game
        list_save = [@@target_word, @@player_picks,@@guess_word,@@turns,@@target_array]
        File.open(@@filename,"w") {|file| file.write(list_save.to_yaml)}
        puts "Game saved."
        exit
        #save a yaml file with the target word, player picks, guess word, and how many turns the player has left
        #https://www.sitepoint.com/choosing-right-serialization-format/
    end

    def load_game
        #set variables to array
        #https://www.sitepoint.com/choosing-right-serialization-format/
        gameload = YAML.load(File.read(@@filename))
        @@target_word = gameload[0]
        @@player_picks = gameload[1]
        @@guess_word = gameload[2]
        @@turns == gameload[3]
        @@target_array = gameload[4]
    end

    def letter_in_word(letter)
        @@flag = 0
        #check if letter is in the word that the player is trying to guess
        @@target_array.each_with_index do |target_letter,index|
            if letter == target_letter
                @@guess_word[index] = letter
                @@flag += 1
            end
        end

        if @@flag == 0
            puts "Letter was not in word!"
            #return 0
            @@turns = @@turns - 1
        else
            puts "Letter was in word!"
        end
        puts "#{@@turns} turn left!"
    end

    def check_win
        #check to see if user has won
        if @@target_array == @@guess_word
            puts "You won!!!!"
            puts "The word was #{@@target_word}"
            exit
        end
    end

    def play_round
        letter = get_letter
        letter_in_word(letter)
    end

    def play_rounds
        while @@turns > 0
            play_round
            check_win
            puts
        end
    end

    def getword
        @@target_word = File.readlines("google-10000-english-no-swears.txt").sample
    end

    def convert_word_to_array
        @@target_array = @@target_word.chars
        @@target_array.pop
        @@target_array.each_with_index do |pos, index|
            @@guess_word[index] = '*'
        end
    end

    def play_game
        getword
        convert_word_to_array
        puts "Choose 1 to play a new game, or 2 to load a saved game."
        loop {
            choice = gets.strip
        if choice.to_s == '1'
            break
        elsif choice.to_s == '2'
            load_game
            break
        else
            puts "invalid selection"
        end
        }
        play_rounds
        puts "Sorry, the word was #{@@target_word}"
    end
end

new_game = Game.new
new_game.play_game