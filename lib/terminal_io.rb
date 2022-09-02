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

  def swap_players(message)
    display ".\n"*50 
    display message
    display "\n"
  end

  def enter_to_continue(message)
    prompt "#{message}\nPress enter to continue."
  end

  def try_again(message)
    "#{message}.\nTry again."
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

  def get_shot(rows:, cols:, board:)
    print_board(board)
    display "Call your shot."
    get_row_col(rows: rows, cols: cols)
  end

  def print_board(board)
    display "\n"
    display board.map {|row| row.join(" ")}.join("\n")
    display "\n"
  end

  def hit(hit, board)
    print_board(board)
    hit == :hit ? enter_to_continue("HIT") : enter_to_continue("MISS")
  end

  def end(winner, board)
    display "Player #{winner}, YOU WON!"
    print_board(board)
  end

  private 

  def game_index(index)
    return index.map {|i| i-1} if index.class == Array 
    index-1
  end

  def show_ships(ships)
    "You have these ships remaining: #{ships.join(", ")}"
  end
end