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

  def swap_players
    swap = prompt "Press enter to swap palyers"
    display ".\n"*50 if swap == ""
  end

  def start
    display "Welcome to the game!"
    display "Set up your ships first."
  end

  def show_ships(ships)
    display "You have these ships remaining: #{ships.join(", ")}"
  end

  def get_ship(ships)
    show_ships(ships)
    ship = prompt "Which do you wish to place?"
    until ships.include?(ship.to_i)
      ship = prompt "Select a valid ship\n#{show_ships(ships)}"
    end
    ship.to_i
  end
  
  def get_dir
    dir = prompt "Vertical or horizontal? [vh]"
    until /[vh]/i =~ dir
      dir = prompt "Please enter valid orientation [v for vertical, h for horizontal]"
    end
    dir
  end

  def get_row_col
    row = prompt("Which row?").to_i
    col = prompt("Which column?").to_i
    [row,col]
  end

  def try_again(feedback)
    display "#{feedback}. Try again"
  end

  def print_board(board)
    display "This is your board now:"
    display board.map {|row| row.join(" ")}.join("\n")
  end
end