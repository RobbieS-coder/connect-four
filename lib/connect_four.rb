require_relative 'board'
require_relative 'player'

class ConnectFour
  def initialize(players = [Player.new, Player.new], board = Board.new)
    @player_one = players.first
    @player_two = players.last
    @current_player = @player_one
    @board = board
  end

  def game_loop
    @board.display_board
    until @board.game_over?
      success = false
      until success
        input = @current_player.player_input
        player_colour = @current_player.token_colour
        success = @board.drop_piece(input, player_colour)
      end
      switch_player
      @board.display_board
    end
    announce_winner
  end

  def switch_player
    @current_player = (@current_player == @player_one ? @player_two : @player_one)
  end

  private

  def announce_winner
    winner = @board.evaluate_winner
    puts winner ? "#{winner.capitalize} has made a line and won!" : 'The board got filled up and no one won!'
  end
end
