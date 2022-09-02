```ruby 
class Ship
  attr_accessor :ship 

  def initialize(length)
    @ship = Array.new(length,false)
  end

  def sunk?
    @ship.all?(true)
  def
end

class Board

  attr_accessor :board

  def initialize(size)
    @board = Array.new(size) {Array.new(size, ".")}
    # indices can be a ship object for ship, nil for empty, :hit for a hit and :miss for a miss
  end

  def get_index(row, col)
    @board[row][col]
  end

  def change_index(row, col, value)
    @board[row][col] = value
  end
end

class Setup
  attr_accessor :board

  def initialize(board, ship_lengths)
    @board, @ship_lengths = board, ship_lengths
    @valid_input_getter = ValidInputGetter.new
  end

  def place_all_ships
    @valid_input_getter.get_ship(board, ship_lengths)

  end

  def place_ship(ship:, dir:, row:, col:)
    case dir
    when :vertical
      ship.times {|x| @board.change_index(row+x,col, Ship.new(ship))}
    when :horizontal
      ship.times {|x| @board.change_index(row,col+x, Ship.new(ship))}
    end
    delete_ship(ship)
  end

  def more_ships?
    @ships.length > 0
  end

  def delete_ship(ship)
    @ships.delete_at(@ships.index_of(ship))
  end
end

class Game
  def initialize(player_1, player_2)
    @player_1, @player_2 = player_1, player_2
  end

  def plaeyr_1_shoot(row, col)
    @player_1.shoot(row, col) if player == :player_1
  end

  def player_2_shoot(row, col)
    @player_2.shoot(row, col) if player == :player_2
  end
end

class Player
  #maybe initializes with already set up board
  def initialize(own_board, opp_board, board_size)
    @own_board = own_board
    @opp_board = Board.new(board_size)
    @win = false
  end

  def shoot(shooter:, opp:)
    #returns false if already shot
  end

  def respond(shooter:, opp:)
    #updates @win = true if all ships shot
  end
end

class TerminalIO
  def initialize(io = Kernel)
    @io = io
  end

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end

  def display(message)
    @io.puts.message
  end
end

class DisplayFormatter
  def initialize
  end

  def format_ships(ships)
    "You have these ships remaining:\n#{ships.join(", ")}"
  end

  def format_board(board) #a 2d array
    #string
  end

  def try_again(message) #string
    #string
  end

  def ask_row
    "Which row?"
  end

  def ask_col
    "Which column?"
  end
end

class ValidInputGetter
  def initialize(io = TerminalIO.new)
    @io = io
    @display = DisplayFormatter.new
  end

  def get_ship_placement(ship:, board:, row:, col:, dir:)
  end

  def get_ship_selection(ships:)
    loop do 
    ship = @io.prompt(@display.format_ships(ships))
    break if ships.include?(ship)
    end 
    ship 
  end

  def get_row_col(board:)
    loop do
    row = @io.prompt(@display.ask_row).to_i
    col = @io.prompt(@display.ask_col).to_i
    break if row <= board.length && row > 0 && col > 0 && col <= board.length
    end
    [row, col].map!{|x| game_index(x)}
  end

  def get_dir
    loop do 
    dir = @io.prompt(@display.ask_dir).to_i
    break if "VHvh".include?(dir)
    end
    dir
  end

  def get_shot
  end

  def game_index(index)
    index - 1
  end
end

class UserInterface
  def initialize(io: = TerminalIO.new, ship_lengths:, board_size:)
    @io,@ship_lengths, @board_size = io, ship_lengths, board_size
  end

  def run
    #player_1_board = setup
    #player_2_board = setup
    #end(loop_players)
  end

  private

  def setup
    setup = Setup.new(Board.new(board_size), @ship_lengths)

    end
  end
  
  def loop_players
    #until @player_1.won? || @player_2.won?
  end

  def end(winner)
    #prints winner
  end
end


