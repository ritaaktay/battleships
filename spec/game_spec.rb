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

  context "checks index" do
    it "alerts ship that does not fit on board horizontally" do
      game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
      expect(game.check_index(row: 8,col: 10, ship: 4, dir: "h")).to eq "Ship does not fit on board."
    end

    it "alerts for ship that does not fit on board vertically" do
      game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
      expect(game.check_index(row: 7,col: 7, ship: 4, dir: "v")).to eq "Ship does not fit on board."
    end

    it "alerts for ship that overlaps with another ship" do
      game = Game.new(ships: [5,4,3,3,2], rows: 10, cols: 10)
      game.place_ship(row:4, col:4, ship: 5, dir: "h")
      expect(game.check_index(row: 3,col: 6, ship: 4, dir: "v")).to eq "Ship overlaps with another."
    end
  end
end