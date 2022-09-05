class Player
  def initialize(own_board:, board_size:, name:)
    @own_board = own_board
    @opp_board = Board.new(board_size)
    @lost = false
    @name = name
  end

  def already_shot?(row:, col:)
    @opp_board[row][col] == :hit || :miss ? true : false
  end

  def shoot(opp:, row:, col:)
    case opp.respond(row: row, col: col)
    when false
      #false
    when :hit
      @opp_board[row][col] = "X"
      #:hit
    when :miss
      @opp_board[row][col] = "O"
      #:miss
    when :end 
      #:end
    end
  end
  
  #be mindful of flow of operations here,
  #when the game ends, @lose is updated to true
  # own_board is marked, response sent as hit
  # opp_board is marked by other player
  # one shot cycle done, new shot cycle only begins by checking condition 
  # if @lost == false for both players 

  def respond(row:, col:)
    case @own_board[row][col]
    #check this syntax with when .class
    when .class == Ship
      @own_board[row][col] = "X"
      #cal all? have a code block? is there a none? method?
      @lost = true if @own_board.faltten.none? {|x| x.class == Ship}
      # return :end if @lose = true
      :hit
    when "."
      @own_board[row][col] = "O"
      :miss
    end
  end

  def lost?
    @lost
  end
end
