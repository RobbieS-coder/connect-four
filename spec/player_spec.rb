require_relative '../lib/player'

describe Player do
	describe '#initialize' do
		context 'when not providing a colour' do
			xit 'asks user to input the token colour' do
				input_request = 'Input the colour you want your token to be: '
        expect(described_class).to receive(:puts).with(input_request)
        described_class.new
			end

			context 'when user has already been asked for input' do
				subject(:new_player) { described_class.new }

				context 'when inputting allowed colour' do
					before do
						allowed_colour = 'blue'
						allow(new_player).to receive(:gets).and_return(allowed_colour)
					end

					xit 'assigns the colour to @token_colour' do
						expect(new_player.instance_variable_get(:@token_colour)).to eq(allowed_colour)
					end
				end

				context 'when inputting not allowed colour' do
					before do
						not_allowed_colour = 'orange'
						allow(new_player).to receive(:gets).and_return(not_allowed_colour)
					end

					xit 'rejects the input and lists allowed colours' do
						expect(new_player.instance_variable_get(:@token_colour)).to eq(not_allowed_colour)
					end
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