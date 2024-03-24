require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    it "asks to input player's name" do
    end

    it "asks to input token colour" do
    end
  end

  describe '#assign_player_name' do
    # indirectly tested through #initialize

    context 'when inputting empty name' do
      it 'rejects the input and asks for another' do
      end
    end

    context 'when inputting any other name' do
      it 'assigns the name' do
      end
    end
  end

  describe '#assign_token_colour' do
    # indirectly tested through #initialize

    context 'when inputting allowed colour' do
      it 'assigns the colour' do
      end
    end

    context 'when inputting not allowed colour' do
      it 'rejects the input and lists allowed colours' do
      end
    end
  end

  describe '#player_input' do
    context 'when inputting a number between 1 and 8' do
      it 'returns the number' do
      end
    end

    context 'when inputting a number out of bounds' do
      it 'rejects the input and asks for another' do
      end
    end

    context 'when inputting a letter' do
      it 'rejects the input and asks for another' do
      end
    end

    context 'when inputting boundary numbers' do
      context 'when inputting lower bound number' do
        it 'returns the number' do
        end
      end

      context 'when inputting upper bound number' do
        it 'returns the number' do
        end
      end
    end
  end
end