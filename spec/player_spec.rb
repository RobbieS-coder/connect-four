require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when creating new player' do
      it 'asks user to input the token colour' do
        input_request = "The available colours are red, green, yellow, blue, magenta and cyan.\nInput your token colour: "
        expect_any_instance_of(described_class).to receive(:puts).with(input_request).once
        allow_any_instance_of(Player).to receive(:gets).and_return('blue')
        described_class.new
      end
    end

    context 'when inputting colours' do
      subject(:new_player) { described_class.new }

      let(:valid_colour) { 'blue' }
      let(:invalid_colour) { 'orange' }

      before do
        allow_any_instance_of(Player).to receive(:puts)
      end

      context 'when inputting valid colour' do
        before do
          allow_any_instance_of(Player).to receive(:gets).and_return(valid_colour)
        end

        it 'assigns the colour to @token_colour' do
          expect(new_player.instance_variable_get(:@token_colour)).to eq(valid_colour)
        end
      end

      context 'when inputting an invalid, then valid colour' do
        before do
          allow_any_instance_of(Player).to receive(:gets).and_return(invalid_colour, valid_colour)
        end

        it 'still assigns the colour to @token_colour' do
          expect(new_player.instance_variable_get(:@token_colour)).to eq(valid_colour)
        end
      end
    end
  end

  describe '#player_input' do
    subject(:input_test) { described_class.new }

    context 'when inputting a number between 1 and 6' do
      before do
        str = '2'
        allow(input_test).to receive(:gets).and_return(str)
      end

      xit 'returns the number' do
        expect(input_test.player_input).to eq(2)
      end
    end

    context 'when inputting a number out of bounds' do
      before do
        str = '7'
        allow(input_test).to receive(:gets).and_return(str)
      end

      xit 'rejects the input and asks for another' do
        expect(input_test.player_input).to be_nil
      end
    end

    context 'when inputting a letter' do
      before do
        str = 'a'
        allow(input_test).to receive(:gets).and_return(str)
      end

      xit 'rejects the input and asks for another' do
        expect(input_test.player_input).to be_nil
      end
    end

    context 'when inputting boundary numbers' do
      context 'when inputting lower bound number' do
        before do
          lower_bound = '1'
          allow(input_test).to receive(:gets).and_return(lower_bound)
        end

        xit 'returns the number' do
          expect(input_test.player_input).to eq(1)
        end
      end

      context 'when inputting upper bound number' do
        before do
          upper_bound = '6'
          allow(input_test).to receive(:gets).and_return(upper_bound)
        end

        xit 'returns the number' do
          expect(input_test.player_input).to eq(6)
        end
      end
    end
  end
end
