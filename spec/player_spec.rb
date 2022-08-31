require 'player'

RSpec.describe Player do
  let(:player) {Player.new(rows: 10, cols: 10, ships: [5,4,3,3,2])}

  describe '.initialize' do
    it {expect(player).to be}
  end

  describe '.place_ship' do
    context 'when vertical' do
      it 'places ship' do
        ships, board = player.unplaced_ships.length, player.own_board.clone
        player.place_ship(row: 4,col: 4, ship: 2, dir: :vertical)
        for r in 0...10
          for c in 0...10
            if [4,5].include?(r) && c == 4
              expect(player.own_board[4][c]).to eq "S"
            else
              expect(player.own_board[r][c]).to eq board[r][c]
            end
          end
        end
        expect(ships - player.unplaced_ships.length).to eq 1
      end
    end

    context 'when horizontal' do
      it 'places ship' do
        ships, board = player.unplaced_ships.length, player.own_board.clone
        player.place_ship(row: 4,col: 4, ship: 2, dir: :horizontal)
        for r in 0...10
          for c in 0...10
            if [4,5].include?(c) && r == 4
              expect(player.own_board[4][c]).to eq "S"
            else
              expect(player.own_board[r][c]).to eq board[r][c]
            end
          end
        end
        expect(ships - player.unplaced_ships.length).to eq 1
      end
    end
  end

  describe '.check_index' do
    context 'when does not fit on board horizontally' do
      subject {player.check_index(row: 8,col: 10, ship: 4, dir: :horizontal)}
      it {is_expected.to eq "Ship does not fit on board"}
    end
  
    context 'when does not fit on board vertically' do
      subject {player.check_index(row: 7,col: 7, ship: 4, dir: :vertical)}
      it {is_expected.to eq "Ship does not fit on board"}
    end
  
    context 'when overlaps with another ship' do
      before {player.place_ship(row:4, col:4, ship: 5, dir: :horizontal)}
      subject {player.check_index(row: 3,col: 6, ship: 4, dir: :vertical)}
      it {is_expected.to eq "Ship overlaps with another"}
    end
  end
end
