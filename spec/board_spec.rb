require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    context 'when not providing a game board' do
      let(:empty_board) { Array.new(7) { Array.new(6, nil) } }

      xit 'assigns empty board to @game_board' do
        empty_board_class = described_class.new
        expect(empty_board_class.instance_variable_get(:@game_board)).to eq(empty_board)
      end
    end

    context 'when providing a used game board' do
      let(:used_board) { double('used_board') }

      xit 'assigns used board to @game_board' do
         used_board_class = described_class.new(used_board)
        expect(used_board_class.instance_variable_get(:@game_board)).to eq(used_board)
      end
    end
  end

  describe '#drop_piece' do
    context 'when drop is successful' do
      context 'when column is empty' do
        subject(:empty_column_drop) { described_class(empty_column) }
        let(:empty_column) { [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }
        let(:empty_column_drop_result) { [
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        before { result = empty_column_drop.drop_piece(1, 'blue') }

        xit 'drops to the bottom' do
          expect(empty_column_drop.instance_variable_get(:@game_board)).to eq(empty_column_drop_result)
        end

        xit 'returns true' do
          expect(result).to eq(true)
        end
      end

      context 'when column is semi-full' do
        subject(:semi_full_column_drop) { described_class(semi_full_column) }
        let(:semi_full_column) { [
          [nil, 'blue', 'red', 'blue', 'red', 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }
        let(:semi_full_column_drop_result) { [
          ['red', 'blue', 'red', 'blue', 'red', 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        before { result = semi_full_column_drop.drop_piece(1, 'red') }

        xit 'drops on top of highest token' do
          expect(semi_full_column_drop.instance_variable_get(:@game_board)).to eq(semi_full_column_drop_result)
        end

        xit 'returns true' do
          expect(result).to eq(true)
        end
      end
    end

    context 'when column is full' do
      subject(:full_column_drop) { described_class(full_column) }
      let(:full_column) { [
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil]
      ] }

      before { result = full_column_drop.drop_piece(1, 'blue') }

      xit '@game_board does not change' do
        expect(full_column_drop.instance_variable_get(:@game_board)).to eq(full_column)
      end

      xit 'returns false' do
        expect(result).to eq(false)
      end
    end
  end

  describe '#game_over?' do
    context 'when someone has won' do
      context 'when a horizontal line has been made' do
        let(:horizontal_win) { [
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit 'returns true' do
          board = described_class.new(horizontal_win)
          result = board.game_over?
          expect(result).eq(true)
        end
      end

      context 'when a vertical line has been made' do
        let(:vertical_win) { [
          [nil, nil, 'blue', 'blue', 'blue', 'blue'],
          [nil, nil, nil, 'red', 'red', 'red'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit 'returns true' do
          board = described_class.new(vertical_win)
          result = board.game_over?
          expect(result).eq(true)
        end
      end

      context 'when a diagonal line has been made' do
        let(:diagonal_win) { [
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, 'blue', 'red'],
          [nil, nil, nil, 'blue', 'red', 'red'],
          [nil, nil, 'blue', 'red', 'red', 'blue'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit 'returns true' do
          board = described_class.new(diagonal_win)
          result = board.game_over?
          expect(result).eq(true)
        end
      end
    end

    context 'when noone has won' do
      context 'when someone has two in a row' do
        let(:two_not_win) { [
          [nil, nil, nil, nil, 'blue', 'blue'],
          [nil, nil, nil, nil, nil, 'red'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit 'returns false' do
          board = described_class.new(two_not_win)
          result = board.game_over?
          expect(result).eq(false)
        end
      end

      context 'when someone has three in a row' do
        let(:three_not_win) { [
          [nil, nil, nil, 'blue', 'blue', 'blue'],
          [nil, nil, nil, nil, 'red', 'red'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit 'returns false' do
          board = described_class.new(three_not_win)
          result = board.game_over?
          expect(result).eq(false)
        end
      end
    end

    context 'when the board is full' do
      let(:full_board_draw) { [
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue']
      ] }

      xit 'returns true' do
        board = described_class.new(full_board_draw)
        result = board.game_over?
        expect(result).eq(true)
      end
    end
  end

  describe '#evaluate_winner' do
    context 'when player_one wins' do
      context 'with a horizontal line' do
        subject(:evaluate_player_one_horizontal_win) { described_class(player_one_horizontal_win) }
        let(:player_one_horizontal_win) { [
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_one's colour" do
          result = evaluate_player_one_horizontal_win.evaluate_winner
          expect(result).to eq('blue')
        end
      end

      context 'with a vertical line' do
        subject(:evaluate_player_one_vertical_win) { described_class(player_one_vertical_win) }
        let(:player_one_vertical_win) { [
          [nil, nil, 'blue', 'blue', 'blue', 'blue'],
          [nil, nil, nil, 'red', 'red', 'red'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_one's colour" do
          result = evaluate_player_one_vertical_win.evaluate_winner
          expect(result).to eq('blue')
        end
      end

      context 'with a diagonal line' do
        subject(:evaluate_player_one_diagonal_win) { described_class(player_one_diagonal_win) }
        let(:player_one_diagonal_win) { [
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, 'blue', 'red'],
          [nil, nil, nil, 'blue', 'red', 'red'],
          [nil, nil, 'blue', 'red', 'red', 'blue'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_one's colour" do
          result = evaluate_player_one_diagonal_win.evaluate_winner
          expect(result).to eq('blue')
        end
      end
    end

    context 'when player two wins' do
      subject(:evaluate_player_two_horizontal_win) { described_class(player_two_horizontal_win) }
      context 'with a horizontal line' do
        let(:player_two_horizontal_win) { [
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, nil, 'red', 'red'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_two's colour" do
          result = evaluate_player_two_horizontal_win.evaluate_winner
          expect(result).to eq('red')
        end
      end

      context 'with a vertical line' do
        subject(:evaluate_player_two_vertical_win) { described_class(player_two_vertical_win) }
        let(:player_two_vertical_win) { [
          [nil, nil, nil, 'blue', 'blue', 'blue'],
          [nil, nil, 'red', 'red', 'red', 'red'],
          [nil, nil, nil, nil, nil, 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_two's colour" do
          result = evaluate_player_two_vertical_win.evaluate_winner
          expect(result).to eq('red')
        end
      end

      context 'with a diagonal line' do
        subject(:evaluate_player_two_diagonal_win) { described_class(player_two_diagonal_win) }
        let(:player_two_diagonal_win) { [
          [nil, nil, nil, nil, nil, 'red'],
          [nil, nil, nil, nil, 'red', 'blue'],
          [nil, nil, nil, 'red', 'blue', 'blue'],
          [nil, nil, 'red', 'blue', 'red', 'blue'],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ] }

        xit "returns player_two's colour" do
          result = evaluate_player_two_diagonal_win.evaluate_winner
          expect(result).to eq('red')
        end
      end
    end

    context 'when board is full' do
      subject(:evaluate_draw) { described_class(full_board_draw) }
      let(:full_board_draw) { [
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['blue', 'red', 'blue', 'red', 'blue', 'red'],
        ['red', 'blue', 'red', 'blue', 'red', 'blue']
      ] }

      xit 'returns nil' do
        result = evaluate_draw.evaluate_winner
        expect(result).to eq(nil)
      end
    end
  end
end