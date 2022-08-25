class Game
  def initialize(ships:, rows:, cols:)
    @rows, @cols = rows, cols
    @unplaced_ships = ships
    @board = Array.new(rows) {Array.new(cols, ".")}
  end

  attr_reader :unplaced_ships, :board, :rows, :cols

  def place_ship(row:, col:, ship:, dir:)
    @io.swap_players
    case dir
    when "v"
      for i in row...row+ship do
        @board[i][col] = "S" 
      end
    when "h"
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
        return "Ship does not fit on board." if !@board[i] || !@board[i][col]
        return "Ship overlaps with another." if @board[i][col] == "S" 
      end
      return true
    when "h"
      for i in col...col+ship do 
        return "Ship does not fit on board."  if !@board[row] || !@board[row][i]
        return "Ship overlaps with another." if @board[row][i] == "S" 
      end
      return true
    end
  end

  def remove_placed_ship(ship)
    @unplaced_ships.delete_at(@unplaced_ships.index(ship))
  end
end
