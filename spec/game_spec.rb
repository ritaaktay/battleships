require 'game'

RSpec.describe Game do
  it "initializes with an array of unplaced ships" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    expect(game.unplaced_ships).to eq [5, 4, 3, 3, 2]
  end

  it "places vertical ship on board starting from top left index" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    board, ships = game.board.clone, game.unplaced_ships.length
    game.place_ship(row: 4,col: 4, ship: 2, dir: "v")
    for r in 0...10
      for c in 0...10
        if [4,5].include?(r) && c == 4
          expect(game.board[4][c]).to eq "S"
        else
          expect(game.board[r][c]).to eq board[r][c]
        end
      end
    end
    expect(ships - game.unplaced_ships.length).to eq 1
  end

  it "places horizontal ship on board starting from top left index" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    board, ships = game.board.clone, game.unplaced_ships.length
    game.place_ship(row: 4,col: 4, ship: 2, dir: "h")
    for r in 0...10
      for c in 0...10
        if [4,5].include?(c) && r == 4
          expect(game.board[4][c]).to eq "S"
        else
          expect(game.board[r][c]).to eq board[r][c]
        end
      end
    end
    expect(ships - game.unplaced_ships.length).to eq 1
  end

  it "does not place ship on board if out of index horizontally" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    expect{  game.place_ship(row: 8,col: 10, ship: 4, dir: "h")  }.to raise_error "Ship out of index"
  end

  it "does not place ship on board if out of index vertically" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    expect{  game.place_ship(row: 7,col: 7, ship: 4, dir: "v")  }.to raise_error "Ship out of index"
  end

  it "does not place ship on board if index is already occupied" do
    game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
    game.place_ship(row:4, col:4, ship: 5, dir: "h")
    expect{  game.place_ship(row: 3,col: 6, ship: 4, dir: "v")  }.to raise_error "Index occupied"
  end
end