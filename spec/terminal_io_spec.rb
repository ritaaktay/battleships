require "terminal_io"

RSpec.describe TerminalIO do 

  let(:io) { double(:io) }
  let(:terminal) { TerminalIO.new(io)}

  describe '.start' do
    before {expect(io).to receive(:puts).with("Welcome to the game!")}
    it {terminal.start}
  end
  
  describe '.display' do
      before {expect(io).to receive(:puts).with("Hello")}
      it {terminal.display("Hello")}
  end

  describe '.prompt' do
    before do 
      allow(io).to receive(:puts)
      allow(io).to receive(:gets).and_return("Rita")
    end
    it {expect(terminal.prompt("What is your name?")).to eq "Rita"}
  end

  describe '.swap_players' do
    before do
      expect(io).to receive(:puts).with("Press enter to swap palyers").ordered
      expect(io).to receive(:gets).and_return("").ordered
      expect(io).to receive(:puts).with(".\n"*50).ordered 
    end
    it {terminal.swap_players}
  end

  describe '.get_ship' do 
    before do
      expect(io).to receive(:puts).with("Select a ship from your fleet\nYou have these ships remaining: 5, 4, 2").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Not a valid ship.\nYou have these ships remaining: 5, 4, 2.\nTry again.").ordered
      expect(io).to receive(:gets).and_return("4").ordered
    end
    it {expect(terminal.get_ship([5,4,2])).to eq 4}
  end

  describe '.get_dir' do
    before do
      expect(io).to receive(:puts).with("Vertical or horizontal? (v\h)").ordered
      expect(io).to receive(:gets).and_return("j").ordered
      expect(io).to receive(:puts).with("Not a valid orientation ('v' for vertical, 'h' for horizontal).\nTry again.").ordered
    end
    context 'when vertival' do
      before {expect(io).to receive(:gets).and_return("v")}
      it {expect(terminal.get_dir).to eq :vertical}
    end
    context 'when horizontal' do
      before {expect(io).to receive(:gets).and_return("h")}
      it {expect(terminal.get_dir).to eq :horizontal}
    end
    context 'when capital letter' do
      before {expect(io).to receive(:gets).and_return("H")}
      it {expect(terminal.get_dir).to eq :horizontal}
    end
  end

  describe '.get_row_col' do
    before do
      expect(io).to receive(:puts).with("Which row?").ordered
      expect(io).to receive(:gets).and_return("14").ordered
      expect(io).to receive(:puts).with("Which column?").ordered
      expect(io).to receive(:gets).and_return("h").ordered
      expect(io).to receive(:puts).with("Not a valid row or column.\nTry again.").ordered
      expect(io).to receive(:puts).with("Which row?").ordered
      expect(io).to receive(:gets).and_return("9").ordered
      expect(io).to receive(:puts).with("Which column?").ordered
      expect(io).to receive(:gets).and_return("6").ordered
    end
    it {expect(terminal.get_row_col(rows:10, cols:10)).to eq [8,5]}
  end

  describe '.try_again' do
    subject {terminal.try_again("Not valid")}
    it {is_expected.to eq "Not valid.\nTry again."}
  end

  describe '.print_board' do
    let (:board) {board = Array.new(10) {Array.new(10, ".")}}
    before do
      board[2][1] = board[3][1] = "S"
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
    end
    it {terminal.print_board(board)}
  end
end