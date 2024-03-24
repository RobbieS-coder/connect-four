require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#initialize' do
    it 'creates two players' do
    end

    it 'creates a board' do
    end
  end

  describe '#game_loop' do
    context 'when game_over? returns false then true' do
      context 'when game_over? returns true' do
        it 'calls #announce_winner' do
        end
      end

      context 'when game_over? returns false once then returns true' do
        it 'runs loop once' do
        end

        it 'calls #announce_winner' do
        end
      end

      context 'when game_over? returns false five times then returns true' do
        it 'runs loop five times' do
        end

        it 'calls #announce_winner' do
        end
      end
    end

    context 'when game_over? returns false and loop runs' do
      it 'calls display_board' do
      end

      it 'calls player_input' do
      end

      it 'calls drop_piece' do
      end

      context 'when drop_piece returns true' do
        it 'continues loop' do
        end
      end

      context 'when drop_piece returns false' do
        it 'calls player_input again' do
        end
      end

      it 'calls switch_player' do
      end
    end
  end

  describe '#game_over?' do
    context 'when someone has won' do
      context 'when a horizontal line has been made' do
        it 'returns true' do
        end
      end

      context 'when a vertical line has been made' do
        it 'returns true' do
        end
      end

      context 'when a diagonal line has been made' do
        it 'returns true' do
        end
      end
    end

    context 'when noone has won' do
      context 'when someone has two in a row' do
        it 'returns false' do
        end
      end

      context 'when someone has three in a row' do
        it 'returns false' do
        end
      end
    end

    context 'when the board is full' do
      it 'returns true' do
      end
    end
  end

  describe '#switch_player' do
    context 'when current_player is player_one' do
      it 'current_player becomes player_two' do
      end
    end

    context 'when current_player is player_two' do
      it 'current_player becomes player_one' do
      end
    end
  end

  describe '#evaluate_winner' do
    context 'when player_one wins' do
      context 'with a horizontal line' do
        it 'returns player_one' do
        end
      end

      context 'with a vertical line' do
        it 'returns player_one' do
        end
      end

      context 'with a diagonal line' do
        it 'returns player_one' do
        end
      end
    end

    context 'when player two wins' do
      context 'with a horizontal line' do
        it 'returns player_two' do
        end
      end

      context 'with a vertical line' do
        it 'returns player_two' do
        end
      end

      context 'with a diagonal line' do
        it 'returns player_two' do
        end
      end
    end

    context 'when board is full' do
      it 'returns nil' do
      end
    end
  end
end