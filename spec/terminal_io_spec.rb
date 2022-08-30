require "terminal_io"

#let > context > before > it

RSpec.describe TerminalIO do 
  it "displays start message" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Welcome to the game!").ordered
    terminal.start
  end

  it "displays messages" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Hello")
    terminal.display("Hello")
  end

  it "prompts user and gets input" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    allow(io).to receive(:puts)
    allow(io).to receive(:gets).and_return("Rita")
    expect(terminal.prompt("What is your name?")).to eq "Rita"
  end

  it "swaps players" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Press enter to swap palyers").ordered
    expect(io).to receive(:gets).and_return("").ordered
    expect(io).to receive(:puts).with(".\n"*50).ordered
    terminal.swap_players
  end

  it "prompts for valid ship until and returns as integer" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Select a ship from your fleet\nYou have these ships remaining: 5, 4, 2").ordered
    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("Not a valid ship.\nYou have these ships remaining: 5, 4, 2.\nTry again.").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(terminal.get_ship([5,4,2])).to eq 4
  end

  it "prompts for valid direction and returns as symbol" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Vertical or horizontal? (v\h)").ordered
    expect(io).to receive(:gets).and_return("j").ordered
    expect(io).to receive(:puts).with("Not a valid orientation ('v' for vertical, 'h' for horizontal).\nTry again.").ordered
    expect(io).to receive(:gets).and_return("H").ordered
    expect(terminal.get_dir).to eq :horizontal
  end

  it "promts for valid row & column and retruns as array" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("Which row?").ordered
    expect(io).to receive(:gets).and_return("10").ordered
    expect(io).to receive(:puts).with("Which column?").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(terminal.get_row_col).to eq [10,2]
  end

  it "formats try again with message" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(terminal.try_again("Not valid")).to eq "Not valid.\nTry again."
  end

  it "prints board" do
    io = double(:io)
    terminal = TerminalIO.new(io)
    expect(io).to receive(:puts).with("This is your board now:").ordered
    expect(io).to receive(:puts).with(". . . . . . . . . .
. . . . . . . . . .
. S . . . . . . . .
. S . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .").ordered
    board = Array.new(10) {Array.new(10, ".")}
    board[2][1] = board[3][1] = "S"
    terminal.print_board(board)
  end
end