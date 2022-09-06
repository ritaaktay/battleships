class Player
  def initialize(own_board:, opp_board:, name:)
    @own_board, @opp_board = own_board, opp_board
    @lost = false
    @name = name
  end

  attr_reader :opp_board

  def already_shot?(row:, col:)
    @opp_board[row][col] == :hit || :miss ? true : false
  end

  def shoot(opp:, row:, col:)
    response = opp.respond(row: row, col: col)
    case response
    when :hit || :sunk
      @opp_board[row][col] = :hit
      response
    when :miss
      @opp_board[row][col] = :miss
      :miss
    end
  end

  def respond(row:, col:)
    case @own_board[row][col]
    when :empty
      @own_board[row][col] = :miss
      :miss
    else 
      ship = @own_board[row][col]
      ship.hit
      @own_board[row][col] = :hit
      @lost = @own_board.lost?
      ship.sunk? :sunk : :hit
    end
  end

  def lost?
    @lost
  end
end
