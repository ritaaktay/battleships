class Game
  def initialize(io:, ships:, rows:, cols:, player:)
    @player1 = player.new(rows: rows, cols: cols, ships: ships.clone)
    @player2 = player.new(rows: rows, cols: cols, ships: ships.clone)
    @io, @rows, @cols = io, rows, cols
  end

  def run
    @io.enter_to_continue("Welcome to the game!\nPlayer 1, ready to place your ships?")
    ship_placement(@player1)
    @io.swap_players(message: "Player 2, ready to place your ships?")
    ship_placement(@player2)
    @io.swap_players(message: "Take turns shooting. Player 1 starts.")
  end

  def ship_placement(player)
    while player.unplaced_ships.length > 0
      ship = @io.get_ship(player.unplaced_ships)
      dir = @io.get_dir
      row, col = get_location(ship: ship, dir: dir, player: player)
      player.place_ship(ship: ship, dir: dir, row: row, col: col, )
      @io.print_board(player.own_board)
    end
    @io.enter_to_continue("Your ships are ready for battle.")
  end

  def get_location(ship:, dir:, player:) 
    row, col = @io.get_row_col(rows: @rows, cols: @cols)
    valid = player.check_index(row: row, col: col, ship: ship, dir: dir)
    while valid != true
      @io.display(@io.try_again(valid))
      row, col = @io.get_row_col(rows: @rows, cols: @cols)
      valid = player.check_index(row: row, col: col,ship: ship, dir: dir)
    end
    [row, col]
  end
end
