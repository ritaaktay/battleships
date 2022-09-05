class ValidInputGetter
  def initialize(io = TerminalIO.new, formatter = DisplayForamtter.new, unplaced_ships: = nil, board:)
    @io, @formatter = io, formatter
    @uncplaced_ships, @board = unplaced_ships, board
    # can I declare nil variables like this?
    @row, @col, @dir, @ship_length
  end

  def get_ship_placement
    get_ship_selection
    get_dir
    get_placement_position
    {ship_length: @ship_length, dir: @dir, row: @row, col: @col}
  end

  def get_shot
    loop do
      get_row_col
      break if @board.check_index(@row,@col) == :hit || :miss
      @io.display(@formatter.invalid_shot)
    end
  end

  private
  
  def get_ship_selection
    loop do 
      @ship_length = @io.prompt(@formatter.format_ships(@unplaced_ships))
      break if @unplaced_ships.include?(ship)
      @io.display(@formatter.invalid_ship)
    end 
  end
  
  def get_placement_position(board:, dir:, ship_length:)
    loop do
      get_row_col
      valid? = ship_is_valid?
      break if valid?
      @io.display(valid?)
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
      return @formatter.out_of_bounds_ship if !fits
      return @formatter.overlapping_ship if overlaps
    end
    true
  end
  
  def get_dir
    loop do 
      dir = @io.prompt(@formatter.ask_dir) 
      break if "VHvh".include?(dir)
      @io.display(@formatter.invalid_dir)
    end
    "Vv".include?(dir) ? @dir = :vertical : @dir = :horizontal
  end

  def get_row_col
    loop do
      @row = game_index(@io.prompt(@formatter.ask_row).to_i)
      @col = game_index(@io.prompt(@formatter.ask_col).to_i)
      break if @row > 0 && @row < @board.size && @col > 0 && @col < @board.size
      @io.display(@formatter.invalid_row_col)
    end
  end

  def game_index(index)
    index - 1
  end
end