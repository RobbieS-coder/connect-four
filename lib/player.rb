require 'pry-byebug'

class Player
  COLOURS = %w[red green yellow blue magenta cyan].freeze

  def initialize
    @token_colour = assign_token_colour
  end

  def player_input; end

  private

  def assign_token_colour
    puts "The available colours are red, green, yellow, blue, magenta and cyan.\nInput your token colour: "
    loop do
      choice = gets.chomp.downcase
      return choice if COLOURS.include?(choice)

      puts 'Invalid colour. The available colours are red, green, yellow, blue, magenta and cyan. '
    end
  end
end
