class Board
  def initialize(size)
    @board = Array.new(size) {Array.new(size, :empty)}
  end

  def check_index(row, col)
    @board[row][col]
  end

  def change_index(row, col, value)
    @board[row][col] = value
  end

  def ship_overlap?(row, col)
    @board[row][col].class == Ship ? true : false
  end

  def ship_fits?(row, col)
    @board[row][col] != nil
  end

  def already_shot?(row,col)
      @board[row][col] == :hit || :miss ? true : false
    end

  def no_ships?
    @board.faltten.none? {|x| x.class == Ship}
  end
end