# frozen_string_literal: true

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

  RESET = "\e[0m"

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

  def game_over?
    horizontal_win? || vertical_win? || diagonal_win? || game_draw?
  end

  def evaluate_winner
    return evaluate_horizontal if horizontal_win?
    return evaluate_vertical if vertical_win?
    return evaluate_diagonal if diagonal_win? # rubocop:disable Style/RedundantReturn
  end

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

  def horizontal_win?
    @game_board.transpose.any? do |row|
      row.chunk_while { |cell, next_cell| cell && cell == next_cell }
         .any? { |chunk| chunk.size >= 4 }
    end
  end

  def evaluate_horizontal
    evaluate_chunks(@game_board.transpose)
  end

  def vertical_win?
    @game_board.any? do |row|
      row.chunk_while { |cell, next_cell| cell && cell == next_cell }
         .any? { |chunk| chunk.size >= 4 }
    end
  end

  def evaluate_vertical
    evaluate_chunks(@game_board)
  end

  def diagonal_win?
    diagonals = collect_diagonals
    diagonals.any? { |diagonal| diagonal.first && diagonal.uniq.length == 1 }
  end

  def evaluate_diagonal
    evaluate_chunks(collect_diagonals)
  end

  def collect_diagonals
    lr_diagonals + rl_diagonals
  end

  def lr_diagonals
    lr_diagonals = []
    board = @game_board
    starting_cells = (0..2).flat_map { |r| (0..3).map { |c| [c, r] } }
    starting_cells.each do |starting_cell|
      c = starting_cell.first
      r = starting_cell.last
      lr_diagonals << [board[c][r], board[c + 1][r + 1], board[c + 2][r + 2], board[c + 3][r + 3]]
    end
    lr_diagonals
  end

  def rl_diagonals
    rl_diagonals = []
    board = @game_board
    starting_cells = (0..2).flat_map { |r| (3..6).map { |c| [c, r] } }
    starting_cells.each do |starting_cell|
      c = starting_cell.first
      r = starting_cell.last
      rl_diagonals << [board[c][r], board[c - 1][r + 1], board[c - 2][r + 2], board[c - 3][r + 3]]
    end
    rl_diagonals
  end

  def evaluate_chunks(arrays)
    arrays.each do |array|
      array.chunk_while { |cell, next_cell| cell && cell == next_cell }
           .each do |chunk|
        return chunk.first if chunk.size >= 4
      end
    end
  end

  def game_draw?
    @game_board.flatten.none?(&:nil?)
  end
end
