require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#initialize' do
    context 'when not passed any parameters' do
      context 'when not passed existing players' do
        it 'creates two new players' do
          expect(Player).to receive(:new).twice.with(no_args)
          described_class.new
        end
      end

      context 'when not passed an existing board' do
        before do
          allow(Player).to receive(:new)
        end

        it 'creates a new board' do
          expect(Board).to receive(:new).once
          described_class.new
        end
      end
    end

    context 'when passed parameters' do
      let(:player_one) { double('player_one') }
      let(:player_two) { double('player_two') }
      let(:players) { [player_one, player_two] }
      let(:board) { double('board') }

      context 'when passed existing players' do
        it 'does not create two new players' do
          expect(Player).not_to receive(:new)
          described_class.new(players, board)
        end
      end

      context 'when passed an existing board' do
        it 'does not create a new board' do
          expect(Board).not_to receive(:new)
          described_class.new(players, board)
        end
      end
    end
  end

  describe '#game_loop' do
    context 'when game_over? returns false then true' do
      subject(:end_game) { described_class.new(players, board) }

      let(:player_one) { double('player_one') }
      let(:player_two) { double('player_two') }
      let(:players) { [player_one, player_two] }
      let(:board) { double('board') }

      before do
        allow(board).to receive(:display_board)
        allow(player_one).to receive(:player_input)
        allow(player_two).to receive(:player_input)
        allow(player_one).to receive(:token_colour)
        allow(player_two).to receive(:token_colour)
        allow(board).to receive(:drop_piece)
        allow(end_game).to receive(:announce_winner)
        allow(board).to receive(:evaluate_winner)
      end

      context 'when game_over? returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(true)
        end

        it 'calls #announce_winner' do
          expect(end_game).to receive(:announce_winner)
          end_game.game_loop
        end
      end

      context 'when game_over? returns false once then returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(false, true)
          allow(board).to receive(:drop_piece).and_return(true)
        end

        it 'runs loop once' do
          expect(board).to receive(:display_board).once
          expect(player_one).to receive(:player_input).once
          expect(board).to receive(:drop_piece).once
          expect(end_game).to receive(:switch_player).once

          end_game.game_loop
        end

        it 'calls #announce_winner' do
          expect(end_game).to receive(:announce_winner)
          end_game.game_loop
        end
      end

      context 'when game_over? returns false five times then returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(false, false, false, false, false, true)
          allow(board).to receive(:drop_piece).and_return(true, true, true, true, true)
        end

        it 'runs loop five times' do
          expect(board).to receive(:display_board).exactly(5).times
          expect(player_one).to receive(:player_input).exactly(3).times
          expect(player_two).to receive(:player_input).twice
          expect(end_game).to receive(:switch_player).exactly(5).times.and_call_original

          end_game.game_loop
        end

        it 'calls #announce_winner' do
          expect(end_game).to receive(:announce_winner)
          end_game.game_loop
        end
      end
    end

    context 'when game_over? returns false and loop runs' do
      subject(:loop_game) { described_class.new(players, board) }

      let(:player_one) { double('player_one') }
      let(:player_two) { double('player_two') }
      let(:players) { [player_one, player_two] }
      let(:board) { double('board') }

      before do
        allow(board).to receive(:game_over?).and_return(false, true)
        allow(board).to receive(:display_board)
        allow(player_one).to receive(:player_input)
        allow(player_two).to receive(:player_input)
        allow(player_one).to receive(:token_colour)
        allow(player_two).to receive(:token_colour)
        allow(board).to receive(:drop_piece).and_return(true)
        allow(loop_game).to receive(:switch_player)
        allow(loop_game).to receive(:announce_winner)
        allow(board).to receive(:evaluate_winner)
      end

      it 'calls display_board' do
        expect(board).to receive(:display_board)
        loop_game.game_loop
      end

      it 'calls player_input' do
        expect(player_one).to receive(:player_input)
        loop_game.game_loop
      end

      it 'calls drop_piece' do
        expect(board).to receive(:drop_piece)
        loop_game.game_loop
      end

      context 'when drop_piece returns true' do
        before do
          allow(board).to receive(:drop_piece).and_return(true)
        end

        it 'continues loop and calls switch_player' do
          expect(loop_game).to receive(:switch_player)
          loop_game.game_loop
        end
      end

      context 'when drop_piece returns false then true' do
        before do
          allow(board).to receive(:drop_piece).and_return(false, true)
        end

        it 'calls player_input again' do
          expect(player_one).to receive(:player_input).twice
          loop_game.game_loop
        end

        it 'continues loop and calls switch_player' do
          expect(loop_game).to receive(:switch_player)
          loop_game.game_loop
        end
      end
    end
  end

  describe '#switch_player' do
    subject(:game) { described_class.new(players) }

    let(:player_one) { double('player_one') }
    let(:player_two) { double('player_two') }
    let(:players) { [player_one, player_two] }

    context 'when current_player is player_one' do
      before { game.instance_variable_set(:@current_player, player_one) }

      it '@current_player becomes player_two' do
        game.switch_player
        expect(game.instance_variable_get(:@current_player)).to eq(player_two)
      end
    end

    context 'when current_player is player_two' do
      before { game.instance_variable_set(:@current_player, player_two) }

      it '@current_player becomes player_one' do
        game.switch_player
        expect(game.instance_variable_get(:@current_player)).to eq(player_one)
      end
    end
  end
end
