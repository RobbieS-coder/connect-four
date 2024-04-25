require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#initialize' do
    context 'when not passed any parameters' do
      context 'when not passed existing players' do
        xit 'creates two new players' do
          expect(Player).to receive(:new).twice.with(no_args)
          described_class.new
        end
      end

      context 'when not passed an existing board' do
        xit 'creates a new board' do
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
        xit 'does not create two new players' do
          expect(Player).to receive(:new).twice.with(players)
          described_class.new(players, board)
        end
      end

      context 'when passed an existing board' do
        xit 'does not create a new board' do
          expect(Board).not_to receive(:new).once
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

      matcher :have_run_loop do
        match do |game|
          expect(board).to receive(:display_board).once
          expect(player_one).to receive(:player_input).once.or(expect(player_two).to receive(:player_input).once)
          expect(board).to receive(:drop_piece).once
          expect(end_game).to receive(:switch_player).once
        end
      end

      context 'when game_over? returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(true)
        end

        xit 'calls #announce_winner' do
          expect(end_game).to receive(evaluate_winner)
          end_game.game_loop
        end
      end

      context 'when game_over? returns false once then returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(false, true)
        end

        xit 'runs loop once' do
          expect(end_game).to have_run_loop.once
          end_game.game_loop
        end

        xit 'calls #announce_winner' do
          expect(end_game).to receive(evaluate_winner)
          end_game.game_loop
        end
      end

      context 'when game_over? returns false five times then returns true' do
        before do
          allow(board).to receive(:game_over?).and_return(false, false, false, false, false, true)
        end

        xit 'runs loop five times' do
          expect(end_game).to have_run_loop.exactly(5)
          end_game.game_loop
        end

        xit 'calls #announce_winner' do
          expect(end_game).to receive(evaluate_winner)
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
        allow(board).to receive(:game_over?).and_return(false)
        allow(board).to receive(:display_board)
        allow(player_one).to receive(:player_input)
        allow(player_two).to receive(:player_input)
        allow(board).to receive(:drop_piece)
        allow(end_game).to receive(:switch_player)
      end

      xit 'calls display_board' do
        expect(board).to receive(:display_board)
        loop_game.game_loop
      end

      xit 'calls player_input' do
        expect(player_one).to receive(:player_input).or(expect(player_two).to receive(:player_input))
        loop_game.game_loop
      end

      xit 'calls drop_piece' do
        expect(board).to receive(:drop_piece)
        loop_game.game_loop
      end

      context 'when drop_piece returns true' do
        before do
          allow(board).to receive(:drop_piece).and_return(true)
        end

        xit 'continues loop and calls switch_player' do
          expect(loop_game).to receive(:switch_player)
          loop_game.game_loop
        end
      end

      context 'when drop_piece returns false then true' do
        before do
          allow(board).to receive(:drop_piece).and_return(false, true)
        end

        xit 'calls player_input again' do
          expect(player_one).to receive(:player_input).twice.or(expect(player_two).to receive(:player_input).twice)
          loop_game.game_loop
        end

        xit 'continues loop and calls switch_player' do
          expect(loop_game).to receive(:switch_player)
          loop_game.game_loop
        end
      end
    end
  end

  describe '#switch_player' do
    let(:player_one) { double('player_one') }
    let(:player_two) { double('player_two') }
    subject(:game) { described_class.new }

    context 'when current_player is player_one' do
      before { game.instance_variable_set(:@current_player, player_one) }

      xit '@current_player becomes player_two' do
        game.switch_player
        expect(game.instance_variable_get(:@current_player)).to eq(player_two)
      end
    end

    context 'when current_player is player_two' do
      before { game.instance_variable_set(:@current_player, player_two) }

      xit '@current_player becomes player_one' do
        game.switch_player
        expect(game.instance_variable_get(:@current_player)).to eq(player_one)
      end
    end
  end
end