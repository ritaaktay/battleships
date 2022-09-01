require 'game'
require 'player'
require 'terminal_io'

RSpec.describe Game do
  let(:io) {double(:io)}
  let(:game) {Game.new(
    io: io,
    player: Player,
    ships: [5,4,3,3,2],
    rows: 10,
    cols: 10,
  )}

  describe '.setup' do
    context 'when valid location' do
      before {valid_set_up}
      it 'sets up all ships for both players' do
        game.setup
      end
    end

    context 'when invalid location' do
      before do
        expect(io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?")
        place_all_but_one_ship
        place_out_of_bounds_ship
        expect(io).to receive(:swap_players).with("Player 2, ready to place your ships?")
        place_all_but_one_ship
        place_overlapping_ship
        expect(io).to receive(:swap_players).with("Take turns shooting. Player 1 starts.")
      end
      it 'loops until valid ship placement' do
        game.setup
      end
    end
  end

  describe '.loop_players' do
    context 'when win' do
      before do
        game.player2.own_board[5][5] = "S"
        expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player2.opp_board).and_return([5,5])
      end
      it 'returns winner as integer' do
        expect(game.loop_players).to eq game.player1
      end
    end

    context 'when looping' do
      before do
        game.player1.own_board[1][1] = "S"
        game.player2.own_board[5][5] = "S"
        game.player2.own_board[5][6] = "S"
        both_players_shoot(player1_row: 5, player1_col: 5, player1_hit: true, player2_row:2, player2_col:6, player2_hit: false)
        expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [5,6]
      end
      it 'loops untill either player has sunk all ships' do
        expect(game.loop_players).to eq game.player1
      end
    end
  end

  xdescribe '.run' do
    context 'when player 1 wins' do
      before do
        game.player1.place_ship(row:0, col:0, dir: :vertical, ship: 4)
        game.player2.place_ship(row:0, col:0, dir: :horizontal, ship: 2)
        both_players_shoot(player1_row: 0, player1_col: 0, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
        both_players_shoot(player1_row: 1, player1_col: 0, player1_hit: false, player2_row:0, player2_col:0, player2_hit: true)
        expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [0,1]
        expect(io).to receive(:end).with(1,game.player1.opp_board)
      end
      it {}
    end

    context 'when player 2 wins' do
      before do
        game.player1.place_ship(row:0, col:0, dir: :vertical, ship: 4)
        game.player2.place_ship(row:0, col:0, dir: :horizontal, ship: 2)
        both_players_shoot(player1_row: 0, player1_col: 0, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
        both_players_shoot(player1_row: 1, player1_col: 0, player1_hit: false, player2_row:0, player2_col:0, player2_hit: true)
        expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [0,1]
        expect(io).to receive(:end).with(1,game.player1.opp_board)
      end
      it {}
    end
  end
end

def both_players_shoot(player1_row:, player1_col:, player1_hit:, player2_row:, player2_col:, player2_hit:)
  expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [player1_row, player1_col]
  expect(io).to receive(:hit).with(player1_hit, game.player1.opp_board).ordered
  expect(io).to receive(:swap_players).with("Player 2, your turn").ordered
  expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player2.opp_board).and_return [player2_row, player2_col]
  expect(io).to receive(:hit).with(player2_hit, game.player2.opp_board).ordered
  expect(io).to receive(:swap_players).with("Player 1, your turn").ordered
end


def valid_set_up
  expect(io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?")
  place_all_but_one_ship
  place_valid_ship
  expect(io).to receive(:swap_players).with("Player 2, ready to place your ships?")
  place_all_but_one_ship
  place_valid_ship
  expect(io).to receive(:swap_players).with("Take turns shooting. Player 1 starts.")
end

def place_all_but_one_ship
  expect(io).to receive(:get_ship).and_return(5).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([1,1]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:get_ship).and_return(4).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([2,2]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:get_ship).and_return(3).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([3,3]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:get_ship).and_return(3).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([4,4]).ordered
  expect(io).to receive(:print_board).ordered
end

def place_valid_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([5,5]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end

def place_out_of_bounds_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([10,10]).ordered
  expect(io).to receive(:try_again).with("Ship does not fit on board").ordered
  expect(io).to receive(:display).ordered
  expect(io).to receive(:get_row_col).and_return([5,5]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end 

def place_overlapping_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([1,1]).ordered
  expect(io).to receive(:try_again).with("Ship overlaps with another").ordered
  expect(io).to receive(:display).ordered
  expect(io).to receive(:get_row_col).and_return([5,5]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end 
