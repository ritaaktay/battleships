class TerminalIO
  def initialize(io = Kernel)
    @io = io
  end

  def prompt(message)
    display message
    @io.gets.chomp
  end

  def display(message)
    @io.puts message
  end

  def swap_players(message:)
    display ".\n"*50 
    enter_to_continue(message) if message
  end

  def enter_to_continue(message)
    prompt "#{message}\nPress enter to continue."
  end

  def show_ships(ships)
    "You have these ships remaining: #{ships.join(", ")}"
  end

  def get_ship(ships)
    ship = prompt "Select a ship from your fleet\n#{show_ships(ships)}"
    until ships.include?(ship.to_i)
      ship = prompt(try_again("Not a valid ship.\n#{show_ships(ships)}"))
    end
    ship.to_i
  end
  
  def get_dir
    dir = prompt "Vertical or horizontal? (v\h)"
    until /[vh]/i =~ dir
      dir = prompt(try_again("Not a valid orientation ('v' for vertical, 'h' for horizontal)"))
    end
    /v/i =~ dir ? :vertical : :horizontal
  end

  def get_row_col(rows:, cols:)
    row = prompt("Which row?").to_i
    col = prompt("Which column?").to_i
    while row > rows || row < 1 || col > cols || col < 1 do
      display(try_again("Not a valid row or column"))
      row = prompt("Which row?").to_i
      col = prompt("Which column?").to_i
    end
    game_index([row,col])
  end

  def game_index(index)
    return index.map {|i| i-1} if index.class == Array 
    index-1
  end

  def try_again(feedback)
    "#{feedback}.\nTry again."
  end

  def print_board(board)
    display "This is your board now:"
    display board.map {|row| row.join(" ")}.join("\n")
  end
end