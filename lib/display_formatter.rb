class DisplayFormatter
  def format_ships(ships)
    "You have these ships remaining:\n#{ships.join(", ")}"
  end

  def format_board(board)
    board.map do |row|
      row.map do |position|
        case position
        when :empty
          "."
        #how to check for class in a when 
        when .class = Ship 
          "S"
        when :hit 
          "X"
        when :miss
          "O"
        end
      end.join(" ")
    end.join("\n")
  end

  def ask_row
    "Which row?"
  end

  def ask_col
    "Which column?"
  end

  def ask_dir
    "Which orientation? 'v' for vertical, 'h' for horizontal."
  end

  def invalid_ship
    try_again("Invalid ship selection")
  end

  def out_of_bounds_ship
    try_again("Ship does not fit on board")
  end

  def overlapping_ship
    try_again("Ship overlaps with another")
  end

  def invalid_shot
    try_again("You already shot at that spot")
  end

  def invalid_dir
    try_again("Not a vlaid orientation. Try 'v' for vertical, 'h' for horizontal.")
  end

  def invalid_row_col
    try_again("Not a valid position")
  end

  def announce_winner(board:, name:)
    "#{name} you won!\n" + format_board(board)
  end

  private

  def try_again(message)
    "#{message}. Try again."
  end
end