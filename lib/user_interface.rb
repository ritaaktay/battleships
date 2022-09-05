class UserInterface
  def initialize(io: = TerminalIO.new, ship_lengths:, board_size:)
    @ship_lengths, @board_size = ship_lengths, board_size
    @formatter, @io = DisplayFormatter.new(), io
    @game = nil
    @turn = "Player 1"
  end

  def run
    set_up
    # @display.begin_shooting
    loop_players
    end_game(game.winner)
  end

  private

  def loop_players
    until game.win?
      swap_players
      @game.player_1_shoot
      #feedback on shot
      swap_players
      @gmae.player_2_shoot
      #feedback on shot
    end
  end

  def set_up
    swap_players
    player_1_board = new_set_up.prepare_board
    swap_players
    player_2_board = new_set_up.prepare_board
    player_1 = Player.new(own_board: player_1_board, board_size: @board_size)
    player_2 = Player.new(own_board: player_2_board, board_size: @board_size)
    @game = Game.new(player_1, player_2)
  end

  def new_set_up
    Setup.new(board: Board.new(@board_size), ship_lengths: @ship_lengths)
  end 

  def swap_players
    @turn == "Player 1" ? @turn = "Player 2" : @turn = "Player 1"
    @io.display(@formatter.swap_players(@turn))
  end

  def end_game(winner)
    #parallel assignment with hashes?
    {name, board} = winner
    @io.display(@formatter.announce_winner(name: name, board: board))
  end
end