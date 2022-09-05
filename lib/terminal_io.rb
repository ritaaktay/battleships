class TerminalIO
  def initialize(io = Kernel)
    @io = io
  end

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end

  def display(message)
    @io.puts message
  end
end