class UserInterface
  def initialize(game, io)
    @game, @io = game, io
  end

  def run
    @io.start
    ship_placement
    #this will actually swap players too
    @io.swap_players
  end

  private

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

  def game_index(index)
    return index.map {|i| i-1} if index.class == Array 
    i-1
  end

  #Flow:
  #TerminalIO gets row_col from user
  #Game checks index validity
  #UserInterface get_location loops the mediation until valid
  #returns to UserInterface palce_ships for placement
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

