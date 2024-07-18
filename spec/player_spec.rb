# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when creating new player' do
      it 'asks user to input the token colour' do
        input_request = "The available colours are red, green, yellow, blue, magenta and cyan.\nInput your token colour: "
        expect_any_instance_of(described_class).to receive(:puts).with(input_request).once
        allow_any_instance_of(described_class).to receive(:gets).and_return('blue')
        described_class.new
      end
    end

    context 'when inputting colours' do
      subject(:new_player) { described_class.new }

      let(:valid_colour) { 'red' }
      let(:valid_colour2) { 'yellow' }
      let(:invalid_colour) { 'orange' }

      before do
        allow_any_instance_of(described_class).to receive(:puts)
      end

      context 'when inputting valid colour' do
        before do
          allow_any_instance_of(described_class).to receive(:gets).and_return(valid_colour)
        end

        it 'assigns the colour to @token_colour' do
          expect(new_player.instance_variable_get(:@token_colour)).to eq(valid_colour)
        end
      end

      context 'when inputting an invalid, then valid colour' do
        before do
          allow_any_instance_of(described_class).to receive(:gets).and_return(invalid_colour, valid_colour2)
        end

        it 'still assigns the colour to @token_colour' do
          expect(new_player.instance_variable_get(:@token_colour)).to eq(valid_colour2)
        end
      end
    end
  end

  describe '#player_input' do
    subject(:input_test) { described_class.new(valid_colour) }

    let(:valid_colour) { 'blue' }
    let(:valid_num_str) { '2' }
    let(:valid_num) { 2 }

    before do
      allow_any_instance_of(described_class).to receive(:puts)
    end

    context 'when inputting a number between 1 and 7' do
      before do
        allow(input_test).to receive(:gets).and_return(valid_num_str)
      end

      it 'returns the valid number' do
        expect(input_test.player_input).to eq(valid_num)
      end
    end

    context 'when inputting a number out of then in bounds' do
      before do
        invalid_num = '8'
        allow(input_test).to receive(:gets).and_return(invalid_num, valid_num_str)
      end

      it 'still returns the valid number' do
        expect(input_test.player_input).to eq(valid_num)
      end
    end

    context 'when inputting a letter then valid number' do
      before do
        letter = 'a'
        allow(input_test).to receive(:gets).and_return(letter, valid_num_str)
      end

      it 'rejects the input and asks for another' do
        expect(input_test.player_input).to eq(valid_num)
      end
    end

    context 'when inputting boundary numbers' do
      context 'when inputting lower bound number' do
        before do
          lower_bound = '1'
          allow(input_test).to receive(:gets).and_return(lower_bound)
        end

        it 'returns the number' do
          expect(input_test.player_input).to eq(1)
        end
      end

      context 'when inputting upper bound number' do
        before do
          upper_bound = '7'
          allow(input_test).to receive(:gets).and_return(upper_bound)
        end

        it 'returns the number' do
          expect(input_test.player_input).to eq(7)
        end
      end
    end
  end
end
