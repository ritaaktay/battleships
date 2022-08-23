require 'game'

RSpec.describe Game do
  it "initializes with an array of unplaced ships" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    expect(game.ships).to eq [5, 4, 3, 3, 2]
  end

  it "places vertical ship on board starting from top left index" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    ships = game.ships.length
    game.place_ship(row: 4,col: 4, ship: 2, dir: "v")
    expect(game.board[3][3]).to eq "S"
    expect(game.board[4][3]).to eq "S"
    expect(ships - game.ships.length).to eq 1
  end

  it "places horizontal ship on board starting from top left index" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    board, ships = game.board.clone, game.ships.length
    game.place_ship(row: 4,col: 4, ship: 2, dir: "h")
    for r in 0...10
      for c in 0...10
        if [3,4].include?(c) && r == 3
          expect(game.board[3][c]).to eq "S"
        else
          expect(game.board[r][c]).to eq board[r][c]
        end
      end
    end
    expect(ships - game.ships.length).to eq 1
  end

  it "does not place ship on board if out of index" do
  end
end