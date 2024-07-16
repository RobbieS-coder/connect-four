class Board
  attr_reader :game_board

  COLOURS = {
    'red' => "\e[31m",
    'green' => "\e[32m",
    'yellow' => "\e[33m",
    'blue' => "\e[34m",
    'magenta' => "\e[35m",
    'cyan' => "\e[36m"
  }.freeze

  RESET = "\e[0m".freeze

  def initialize(game_board = new_board)
    @game_board = game_board
  end

  def display_board
    puts (1..7).to_a.join(' ')
    transposed_board = @game_board.transpose
    transposed_board.each do |row|
      colourised_row = row.map { |cell| colourise_circle(cell) }
      puts colourised_row.join(' ')
    end
  end

  def drop_piece(column, colour)
    column_index = column - 1
    @game_board[column_index].reverse_each.with_index do |cell, cell_index|
      if cell.nil?
        @game_board[column_index][5 - cell_index] = colour
        return true
      end
    end
    false
  end

  def game_over?; end

  def evaluate_winner; end

  private

  def new_board
    Array.new(7) { Array.new(6, nil) }
  end

  def empty_circle
    "\u2B24"
  end

  def colourise_circle(colour)
    return "#{COLOURS[colour]}#{empty_circle}#{RESET}" if colour

    empty_circle
  end
end
