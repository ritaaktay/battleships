class UserInterface
  def initialize(input: = Input.new, output: = Output.new, ship_lengths:, board_size:)
    @ship_lengths, @board_size = ship_lengths, board_size
    @input, @output = input, output
    @turn = :player_1
  end

  def run
    start
    setup
    loop_players
    end_game
  end

  private

  def start
    @output.start(@turn)
    @input.enter_to_continue
  end
  
  def setup
    setup = Setup.new(board_size: @board_size, ship_lengths: @ship_lengths)
    player_1_board = setup.prepare_board
    @output.ready_for_battle
    swap_players
    setup = Setup.new(board_size: @board_size, ship_lengths: @ship_lengths)
    player_2_board = setup.prepare_board
    @output.ready_for_battle
    swap_players
    @game = Game.new(player_1_board: player_1_board,player_2_board: player_2_board, board_size: @board_size)
  end

  def loop_players
    loop do 
      swap_players(@turn)
      shot, board = @game.player_1_shoot.values_at(:shot, :board)
      break if game.win?
      @output.after_shot(shot: shot, board: board)
      swap_players(@turn)
      shot, board = @game.player_1_shoot.values_at(:shot, :board)
      break if game.win?
      @output.after_shot(shot: shot, board: board)
    end
  end

  def swap_players
    @input.enter_to_continue
    @turn == :player_1 ? @turn = :player_2 : @turn = :player_1
    @output.swap_players(@turn)
  end

  def end_game
    @output.announce_winner(@game.winner)
  end
end