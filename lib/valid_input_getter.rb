class ValidInputGetter
  def initialize(input: = Input.new, output: = Output.new, unplaced_ships: = nil, board:)
    @input, @output = input, output
    @uncplaced_ships, @board = unplaced_ships, board
  end

  def get_ship_placement
    get_ship_selection
    get_dir
    get_placement_position
    {ship_length: @ship_length, dir: @dir, row: @row, col: @col}
  end

  def get_shot(opp_board)
    loop do
      @output.prepare_shot(opp_board)
      get_row_col
      break if opp_board.check_index(@row,@col) == :hit || :miss
      @output.invalid_shot
    end
    {row: @row, col: @col}
  end

  private
  
  def get_ship_selection
    loop do 
      @ship_length = @input.ship_selection(@unplaced_ships)
      break if @unplaced_ships.include?(ship)
      @output.invalid_ship_selection
    end 
  end
  
  def get_placement_position(board:, dir:, ship_length:)
    loop do
      get_row_col
      valid? = ship_is_valid? 
      break if valid?
      @output.invalid_ship_placement(valid?)
    end
  end

  def ship_is_valid?
    @ship_length.times do |x|
      case @dir
      when :vertical
        fits = @board.ship_fits?(@row+x, @col)
        overlaps = @board.ship_overlaps?(@row+x, @col)
      when :horizontal
        fits = @board.ship_fits?(@row, @col+x)
        overlaps = @board.ship_overlaps?(@row, @col+x)
      end
      return :out_of_bounds if !fits
      return :overlap if overlaps
    end
    true
  end
  
  def get_dir
    loop do 
      dir = @input.ask_dir
      break if "VHvh".include?(dir)
      @output.invalid_dir
    end
    "Vv".include?(dir) ? @dir = :vertical : @dir = :horizontal
  end

  def get_row_col
    loop do
      @row = game_index(@input.ask_row)
      @col = game_index(@input.ask_col)
      break if @row > 0 && @row < @board.size && @col > 0 && @col < @board.size
      @output.invalid_row_col
    end
  end

  def game_index(index)
    index - 1
  end
end