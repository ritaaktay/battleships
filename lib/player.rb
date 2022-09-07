class Player
  def initialize(own_board:, opp_board:)
    @own_board, @opp_board = own_board, opp_board
    @lost? = false
  end

  attr_reader :opp_board, :lost?

  def shoot(opp:, row:, col:)
    response = opp.respond(row,col)
    case response
    when :hit || :sunk
      @opp_board.change_index(row,col,:hit)
    when :miss
      @opp_board(row,col,:miss)
    end
    response
  end

  def respond(row, col)
    case @own_board.check_index(row,col)
    when :empty
      @own_board.change_index(row,col,:miss)
      :miss
    else 
      ship = @own_board.check_index(row,col)
      ship.hit
      response = ship.sunk? :sunk : :hit
      @own_board.change_index(row,col,:hit)
      @lost = @own_board.no_ships?
      response
    end
  end
end
