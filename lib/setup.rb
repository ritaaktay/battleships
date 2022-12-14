class Setup
  def initialize(board_size:, ship_lengths:)
    @board = Board.new(@board_size)
    @unplaced_ships = ship_lengths
  end

  def prepare_board
    loop do 
      input_getter = ValidInputGetter.new(board: @board, unplaced_ships: @unplaced_ships)
      placement = input_getter.get_ship_placement
      ship_length, dir, row, col = palcement.values_at(:ship_length, :dir, :row, :col)
      place_ship(ship_length: ship_length, dir: dir, row:row, col:col)
      delete_ship(ship)
      break if @unplaced_ships.length == 0
    end
    @board
  end

  private

  def place_ship(ship_length:, dir:, row:, col:, board:)
    case dir
    when :vertical
      ship_length.times {|x| @board.change_index(row+x,col, Ship.new(ship_length))}
    when :horizontal
      ship_length.times {|x| @board.change_index(row,col+x, Ship.new(ship_length))}
    end
    delete_ship(ship)
  end

  def more_ships?
    @unplaced_ships.length > 0
  end

  def delete_ship(ship)
    @unplaced_ships.delete_at(@unplaced_ships.index_of(ship))
  end
end