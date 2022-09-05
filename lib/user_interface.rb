class UserInterface
  def initialize(io: = TerminalIO.new, ship_lengths:, board_size:)
    @io,@ship_lengths, @board_size = io, ship_lengths, board_size
    @formatter = DisplayFormatter.new()
  end

  def run
    # While game is being set up how does swap players work?
    # Where does the display logic go?
    player_1_board = setup.place_all_ships
    player_2_board = setup.place_all_ships
    # While game is running how does swap palyers work?
    # Where does the display logic go?
    # does game call on @io 
    # or does UserInterface do the looping and call on @io
    winner = game.run
    end(winner)
  end

  private

  def setup
    Setup.new(board: Board.new(@board_size), ship_lengths: @ship_lengths)
  end

  def game
    player_1 = Player.new(own_board: player_1_board, board_size: @board_size, @name "Player 1")
    player_2 = Player.new(own_board: player_2_board, board_size: @board_size, @name "Player 2")
    Game.new(player_1, player_2)
  end

  def end(winner)
    #parallel assignment with hashes?
    {name, board} = winner
    @io.display(@formatter.announce_winner(name: name, board: board))
  end
end