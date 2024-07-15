class Board
  def initialize(game_board = new_board)
    @game_board = game_board
  end

  def display_board; end

  def drop_piece; end

  def game_over?; end

  def evaluate_winner; end

  private

  def new_board
    Array.new(7) { Array.new(6, nil) }
  end
end
