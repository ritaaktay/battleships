class Game
  def initialize(io:, player1:, player2:, ships:, rows:, cols:)
    @player1, @player2 = player1, player2
    @rows, @cols, @ships = rows, cols, ships
    @io = io
  end

  attr_reader :rows, :cols, :ships

  def run
    @io.start
    ship_placement
    @io.swap_players
  end

  def ship_placement
    while @game.unplaced_ships.length > 0
      ship = @io.get_ship(@game.unplaced_ships)
      dir = @io.get_dir
      row, col = get_location(ship: ship, dir: dir)
      @game.place_ship(ship: ship, dir: dir, row: row, col: col, )
      @io.print_board(@game.board)
    end
    @io.display "Your ships are ready for battle"
  end

  def get_location(ship:, dir:) 
    row, col = game_index(@io.get_row_col(rows: @game.rows, cols: @game.cols))
    valid = @game.check_index(row: row, col: col, ship: ship, dir: dir)
    while valid != true
      @io.display(@io.try_again(valid))
      row, col = game_index(@io.get_row_col(rows: @game.rows, cols: @game.cols))
      valid = @game.check_index(row: row, col: col,ship: ship, dir: dir)
    end
    [row, col]
  end
end
