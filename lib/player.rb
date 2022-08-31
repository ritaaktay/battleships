class Player
  def initialize(rows:, cols:, ships:)
    @own_board = Array.new(rows) {Array.new(cols, ".")}
    @opp_board = Array.new(rows) {Array.new(cols, ".")}
    @unplaced_ships = ships
  end

  attr_reader :unplaced_ships, :own_board, :opp_board

  def place_ship(row:, col:, ship:, dir:)
    case dir
    when :vertical
      for i in row...row+ship do
        @own_board[i][col] = "S" 
      end
    when :horizontal
      for i in col...col+ship do 
        @own_board[row][i] = "S" 
      end
    end
    remove_ship(ship)
  end

  def remove_ship(ship)
    @unplaced_ships.delete_at(@unplaced_ships.index(ship))
  end

  def check_index(row:, col:, ship:, dir:)
    case dir
    when :vertical
      for i in row...row+ship do
        return "Ship does not fit on board" if !@own_board[i] || !@own_board[i][col]
        return "Ship overlaps with another" if @own_board[i][col] == "S" 
      end
      return true
    when :horizontal
      for i in col...col+ship do 
        return "Ship does not fit on board"  if !@own_board[row] || !@own_board[row][i]
        return "Ship overlaps with another" if @own_board[row][i] == "S" 
      end
      return true
    end
  end

end