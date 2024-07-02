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
    until @board.game_over?
      @board.display_board
      success = false
      until success
        input = @current_player.player_input
        success = @board.drop_piece(input)
      end
      switch_player
    end
    announce_winner
  end

  def switch_player
    @current_player = (@current_player == @player_one ? @player_two : @player_one)
  end

  def announce_winner
    puts "#{@board.evaluate_winner} has made a line!"
  end
end
