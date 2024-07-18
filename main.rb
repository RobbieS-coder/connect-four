require_relative 'lib/connect_four'

def main
  loop do
    ConnectFour.new.game_loop
    break unless play_again?
  end
  puts 'Thank you for playing!'
end

def play_again?
  puts 'Do you want to play again? (y/n)'
  loop do
    choice = gets.chomp.downcase
    return choice == 'y' if %w[y n].include?(choice)

    puts "Invalid input. Please enter 'y' for yes or 'n' for no."
  end
end

main
