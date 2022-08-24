require 'io'

class UserInterface
  def initialize(game, io)
    @game, @io = game, io
  end

  def run
    @io.start
    place_ships
  end

  private

  def place_ships
    ship = @io.get_ship(@game.unplaced_ships)
    dir = @io.get_dir
    row, col = get_location(ship: ship, dir: dir)
    @game.place_ship(
      ship: ship,
      dir: dir,
      row: row,
      col: col, 
    )
    @io.print_board(@game.board)
  end

  def get_location(ship:, dir:)
      row, col = @io.get_row_col
      valid = @game.check_index(row: row, col: col, ship: ship, dir: dir)
      while valid != true
        @io.display "#{valid} Try again."
        row, col = @io.get_row_col
        valid = @game.check_index(row: row, col: col,ship: ship, dir: dir)
      end
      [row, col]
  end
end

