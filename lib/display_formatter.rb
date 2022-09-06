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
        when :hit 
          "X"
        when :miss
          "O"
        else 
          "S"
        end
      end.join(" ")
    end.join("\n")
  end

  def winner_announcement(board:, name:)
    "#{name} you won!\n" + format_board(board)
  end

  def try_again(message)
    "#{message}. Try again."
  end

  def shot_message(shot)
    "HIT." if shot == :hit
    "MISS." if shot == :miss
    "You sunk my ship!" if shot == :sunk
  end
end