class Input
  def initialize(@io = TerminalIO.new, formatter = DisplayFormatter.new)
    @io, @formatter = io, formatter
  end

  def ask_row
    prompt("Which row?").to_i
  end

  def ask_col
    prompt("Which column?").to_i
  end

  def ask_dir
    prompt "Which orientation?"
  end

  def enter_to_continue(message = "Enter to continue.")
    prompt message
    nil
  end

  def aks_ship_selection(@unplaced_ships)
    prompt(@formatter.format_ships(@unplaced_ships))
  end

  private

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end
end