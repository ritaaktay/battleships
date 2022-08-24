class TerminalIO
  def initialize(io = Kernel)
    @io = io
  end

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end

  def display(message)
    @io.puts message
  end

  def start
    @io.puts "Welcome to the game!"
    @io.puts "Set up your ships first."
  end

  def game_index(index)
    index - 1
  end

  def show_ships(ships)
    @io.puts "You have these ships remaining: #{ships.join(", ")}"
  end

  def get_ship(ships)
    show_ships(ships)
    ship = prompt "Which do you wish to place?"
    while !ships.include?(ship.to_i)
      ship = prompt "Select a valid ship\n#{show_ships(ships)}"
    end
    ship.to_i
  end
  
  def get_dir
    dir = prompt "Vertical or horizontal? [vh]"
    while !"VHvh".include?(dir)
      dir = prompt "Please enter valid orientation [v for vertical, h for horizontal]"
    end
    dir
  end

  def get_row_col
    row = game_index(prompt("Which row?").to_i)
    col = game_index(prompt("Which column?").to_i)
    [row,col]
  end

  def print_board(board)
    @io.puts "This is your board now:"
    @io.puts board.map {|row| row.join(" ")}.join("\n")
  end
end