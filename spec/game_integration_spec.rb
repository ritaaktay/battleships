require 'game'
require 'player'
require 'terminal_io'

RSpec.describe Game do
  let(:io) {double(:io)}
  let(:game) {Game.new(
    io: io,
    player: Player,
    ships: [4,2],
    rows: 10,
    cols: 10,
  )}

  describe '.run' do
    context 'when invalid setup' do
      it 'loops until valid setup' do
        invalid_setup
        player1_wins
        game.run
      end
    end

    context 'when player 1 wins' do
      it 'exits loop' do
        valid_set_up
        player1_wins
        game.run
      end
    end

    context 'when player 2 wins' do
      it 'exits loop' do
        valid_set_up
        player2_wins
        game.run
      end
    end
  end
end

def player1_wins
  both_players_shoot(player1_row: 2, player1_col: 2, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
  both_players_shoot(player1_row: 3, player1_col: 2, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
  both_players_shoot(player1_row: 0, player1_col: 0, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
  both_players_shoot(player1_row: 1, player1_col: 0, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
  both_players_shoot(player1_row: 2, player1_col: 0, player1_hit: true, player2_row:8, player2_col:8, player2_hit: false)
  expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [3,0]
  expect(io).to receive(:end).with(1,game.player1.opp_board)
end

def player2_wins
  both_players_shoot(player2_row: 2, player2_col: 2, player2_hit: true, player1_row:8, player1_col:8, player1_hit: false)
  both_players_shoot(player2_row: 3, player2_col: 2, player2_hit: true, player1_row:8, player1_col:8, player1_hit: false)
  both_players_shoot(player2_row: 0, player2_col: 0, player2_hit: true, player1_row:8, player1_col:8, player1_hit: false)
  both_players_shoot(player2_row: 1, player2_col: 0, player2_hit: true, player1_row:8, player1_col:8, player1_hit: false)
  both_players_shoot(player2_row: 2, player2_col: 0, player2_hit: true, player1_row:8, player1_col:8, player1_hit: false)
  expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player1.opp_board).and_return [8, 8]
  expect(io).to receive(:hit).with(false, game.player1.opp_board).ordered
  expect(io).to receive(:swap_players).with("Player 2, your turn").ordered
  expect(io).to receive(:get_shot).with(rows:10, cols:10, board: game.player2.opp_board).and_return [3, 0]
  expect(io).to receive(:end).with(2,game.player2.opp_board)
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
  place_one_valid_ship
  place_final_valid_ship
  expect(io).to receive(:swap_players).with("Player 2, ready to place your ships?")
  place_one_valid_ship
  place_final_valid_ship
  expect(io).to receive(:swap_players).with("Take turns shooting. Player 1 starts.")
end

def invalid_setup
  expect(io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?")
  place_one_valid_ship
  place_out_of_bounds_ship
  expect(io).to receive(:swap_players).with("Player 2, ready to place your ships?")
  place_one_valid_ship
  place_overlapping_ship
  expect(io).to receive(:swap_players).with("Take turns shooting. Player 1 starts.")
end 

def place_one_valid_ship
  expect(io).to receive(:get_ship).and_return(4).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([0,0]).ordered
  expect(io).to receive(:print_board).ordered
end

def place_final_valid_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([2,2]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end

def place_out_of_bounds_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([10,10]).ordered
  expect(io).to receive(:try_again).with("Ship does not fit on board").ordered
  expect(io).to receive(:display).ordered
  expect(io).to receive(:get_row_col).and_return([2,2]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end 

def place_overlapping_ship
  expect(io).to receive(:get_ship).and_return(2).ordered
  expect(io).to receive(:get_dir).and_return(:vertical).ordered
  expect(io).to receive(:get_row_col).and_return([0,0]).ordered
  expect(io).to receive(:try_again).with("Ship overlaps with another").ordered
  expect(io).to receive(:display).ordered
  expect(io).to receive(:get_row_col).and_return([2,2]).ordered
  expect(io).to receive(:print_board).ordered
  expect(io).to receive(:enter_to_continue).with("Your ships are ready for battle.").ordered
end 
