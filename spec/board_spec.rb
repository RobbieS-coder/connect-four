require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    context 'when providing a used game board' do
      it 'assigns used board to @game_board' do
      end
    end

    context 'when not providing a game board' do
      it 'assigns empty board to @game_board' do
      end
    end
  end

  describe '#drop_piece' do
    context 'when drop is successful' do
      context 'when column is empty' do
        it 'drops to the bottom' do
        end

        it 'returns true' do
        end
      end

      context 'when column is semi-full' do
        it 'drops on top of highest token' do
        end

        it 'returns true' do
        end
      end
    end

    context 'when column is full' do
      it 'rejects column choice' do
      end

      it 'returns false' do
      end
    end
  end
end