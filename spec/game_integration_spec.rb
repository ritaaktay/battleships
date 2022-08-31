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

  describe '.initialize' do
    it {expect(game).to be}
  end

  describe '.setup' do
    context 'when valid location' do
      before do
        expect(io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?")
        place_all_but_one_ship
        place_valid_ship
        expect(io).to receive(:swap_players).with(message:"Player 2, ready to place your ships?")
        place_all_but_one_ship
        place_valid_ship
        expect(io).to receive(:swap_players).with(message: "Take turns shooting. Player 1 starts.")
      end
      it {game.setup}
    end

    context 'when invalid location' do
      before do
        expect(io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?")
        place_all_but_one_ship
        place_out_of_bounds_ship
        expect(io).to receive(:swap_players).with(message:"Player 2, ready to place your ships?")
        place_all_but_one_ship
        place_overlapping_ship
        expect(io).to receive(:swap_players).with(message: "Take turns shooting. Player 1 starts.")
      end
      it {game.setup}
    end
  end

  describe '.shots_loop' do
    context 'when win' do
      before do
        game.player2.own_board[5][5] = "S"
        expect(io).to receive(:get_shot).with(rows:10, cols:10).and_return([5,5])
      end
      it {expect(game.loop_players).to eq 1}
    end

    context 'when looping' do
      before do
        game.player1.own_board[1][1] = "S"
        game.player2.own_board[5][5] = "S"
        game.player2.own_board[5][6] = "S"
        expect(io).to receive(:get_shot).with(rows:10, cols:10).and_return [5,5]
        expect(io).to receive(:hit).with(true, game.player1.opp_board).ordered
        expect(io).to receive(:swap_players).with("Player 2, your turn").ordered
        expect(io).to receive(:get_shot).with(rows:10, cols:10).and_return [2,2]
        expect(io).to receive(:hit).with(false, game.player2.opp_board).ordered
        expect(io).to receive(:swap_players).with("Player 1, your turn").ordered
        expect(io).to receive(:get_shot).with(rows:10, cols:10).and_return [5,6]
      end
      it {expect(game.loop_players).to eq 1}
    end
  end
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
