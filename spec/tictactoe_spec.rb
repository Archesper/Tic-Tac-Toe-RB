require './tictactoe'

describe Board do
  subject(:board) { described_class.new }
  
  describe '#winner_sigil' do
    context "when a player wins, returns their sigil" do
      it 'returns sigil for horizontal win' do
        sigil = 'X'
        board.put(1, sigil)
        board.put(2, sigil)
        board.put(3, sigil)
        winner_sigil = board.winner_sigil
        expect(winner_sigil).to eql(sigil)
      end

      it 'returns sigil for diagonal win' do
        sigil = 'O'
        board.put(1, sigil)
        board.put(5, sigil)
        board.put(9, sigil)
        winner_sigil = board.winner_sigil
        expect(winner_sigil).to eql(sigil)
      end

      it 'returns sigil for vertical win' do
        sigil = 'F'
        board.put(1, sigil)
        board.put(4, sigil)
        board.put(7, sigil)
        winner_sigil = board.winner_sigil
        expect(winner_sigil).to eql(sigil)
      end

      it 'returns "TIE" when there is a tie' do
        sigil1 = 'X'
        sigil2 = 'O'
        board.instance_variable_set(:@board, [
          sigil1, sigil2, sigil1,
          sigil1, sigil2, sigil2,
          sigil2, sigil1, sigil2,
        ])
        winner_sigil = board.winner_sigil
        expect(winner_sigil).to eql('TIE')
      end
    end

    describe '#next_player' do
      let(:game) { instance_double(Game) }
      let(:player1) { instance_double(Player, sigil: 'X')}
      let(:player2) { instance_double(Player, sigil: 'O')}
      context 'when board is empty' do
        it 'sends first_player message to game object' do
          allow(game).to receive(:first_player)
          expect(game).to receive(:first_player)
          board.next_player(player1, player2, game)
        end
      end
      
      context 'when board is not empty' do
        it 'returns player1 when board has less Xs than Os' do
          board.put(1, 'O')
          next_player = board.next_player(player1, player2, game)
          expect(next_player).to equal(player1)
        end

        it 'returns player2 when board has more Xs than Os' do
          board.put(2, 'X')
          next_player = board.next_player(player1, player2, game)
          expect(next_player).to equal(player2)
        end
      end
    end
  end
end

describe Game do
  describe '.player_move' do
    subject(:game) { described_class.new(player, other_player) }
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player, sigil: 'X', name: '') }
    let(:other_player) { instance_double(Player, sigil: 'O') }
    before do
      allow(board).to receive(:put)
      allow(Game).to receive(:puts)
    end

    context 'when input is valid' do
      it 'finishes loop and sends put message to board object' do
        valid_input = '5'
        allow(Game).to receive(:gets).and_return(valid_input)
        expect(Game).to receive(:puts).twice
        expect(board).to receive(:put).once
        Game.player_move(player, board)
      end
    end

    context 'when invalid input is received twice, then valid input is received' do
      it 'finishes loop and sends put message to board object' do
        letter = 'a'
        large_number = '75'
        valid_input = '5'
        allow(Game).to receive(:gets).and_return(letter, large_number, valid_input)
        expect(Game).to receive(:puts).exactly(4).times
        expect(board).to receive(:put).once
        Game.player_move(player, board)
      end
    end
  end
end