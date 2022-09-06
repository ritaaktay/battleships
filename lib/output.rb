class Output
  def initialize(io = TerminalIO.new, formatter = DisplayFormatter.new)
    @io, @formatter = io, formatter
  end

  def display(message)
    @io.puts message
  end

  def start(player)
    display "Take turns preparing your ships, then take turns shooting.\n#{player.to_s} starts."
  end

  def prepare_shot(board)
    display @formatter.format_board(board)
    display "Take your shot."
  end

  def swap_players(player)
    display ".\n"*50 + "#{player.to_s}, your turn"
  end

  def ready_for_battle
    display "Your ships are ready for battle."
  end

  def invalid_ship_selection
    display @formatter.try_again("Invalid ship selection")
  end

  def invalid_ship_placement(type)
    case type
    when :overlapping
      display @formatter.try_again("Ship overlaps with another")
    when :out_of_bounds
      display @formatter.try_again("Ship does not fit on board")
    end
  end

  def invalid_shot
    display @formatter.try_again("You already shot at that spot")
  end

  def invalid_dir
    display @formatter.try_again("Not a vlaid orientation. Try 'v' for vertical, 'h' for horizontal.")
  end

  def invalid_row_col
    display @formatter.try_again( "Not a valid position")
  end

  def after_shot(shot:, board:)
    display @formatter.format_board(board)
    display @formatter.shot_message(shot)
  end

  def announce_winner(name:, board:)
    display @formatter.winner_announcement(board:, name:)
  end
end