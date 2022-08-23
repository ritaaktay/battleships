class Game
  def initialize(ships:, rows:, cols:)
    @ships = ships
    @board = Array.new(rows) {Array.new(cols, ".")}
  end

  attr_reader :ships, :board

  def place_ship(row:, col:, ship:, dir:)
    if dir == "v"
      for i in row-1...row+ship-1 do @board[i][col-1] = "S" end
    elsif dir == "h" 
      for i in col-1...col+ship-1 do @board[row-1][i] = "S" end
    end
    remove_ship(ship)
  end

  def remove_ship(ship)
    @ships.delete_at(@ships.index(ship))
  end
end
