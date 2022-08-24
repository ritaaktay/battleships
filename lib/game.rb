class Game
  def initialize(ships:, rows:, cols:)
    @unplaced_ships = ships
    @board = Array.new(rows) {Array.new(cols, ".")}
  end

  attr_reader :unplaced_ships, :board

  def print
    for row in @board
      p row
    end
  end

  def place_ship(row:, col:, ship:, dir:)
    case dir
    when "v"
      check_index(row: row, col: col, ship: ship, dir: dir)
      for i in row...row+ship do
        @board[i][col] = "S" 
      end
    when "h"
      check_index(row: row, col: col, ship: ship, dir: dir)
      for i in col...col+ship do 
        @board[row][i] = "S" 
      end
    end
    remove_placed_ship(ship)
  end

  def check_index(row:, col:, ship:, dir:)
    case dir
    when "v"
      for i in row...row+ship do
        fail "Ship out of index" if !@board[i] || !@board[i][col]
        fail "Index occupied" if @board[i][col] == "S" 
      end
    when "h"
      for i in col...col+ship do 
        fail "Ship out of index" if !@board[row] || !@board[row][i]
        fail "Index occupied" if @board[row][i] == "S" 
      end
    end
  end

  def remove_placed_ship(ship)
    @unplaced_ships.delete_at(@unplaced_ships.index(ship))
  end
end
