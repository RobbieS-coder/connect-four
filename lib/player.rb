# frozen_string_literal: true

class Player
  attr_reader :token_colour

  COLOURS = %w[red green yellow blue magenta cyan].freeze

  @@player_colours = []
  @@player_count = 0

  def initialize(token_colour = assign_token_colour)
    if @@player_count == 1
      @@player_colours = []
      @@player_count = 0
    end
    @token_colour = token_colour
    @@player_count += 1
  end

  def player_input
    puts "#{token_colour.capitalize}'s turn\nInput the column number from 1-7: "
    loop do
      choice = gets.chomp.to_i
      return choice if choice.between?(1, 7)

      puts 'Invalid input. Input the column number from 1-7: '
    end
  end

  private

  def assign_token_colour
    puts "The available colours are red, green, yellow, blue, magenta and cyan.\nInput your token colour: "
    loop do
      choice = gets.chomp.downcase
      if COLOURS.include?(choice) && !@@player_colours.include?(choice)
        @@player_colours << choice
        return choice
      end

      puts 'Invalid colour. The available colours are red, green, yellow, blue, magenta and cyan. '
    end
  end
end
