require "terminal_io"

RSpec.describe TerminalIO do 

  let(:io) { double(:io) }
  let(:terminal) { TerminalIO.new(io)}
  let (:empty_board) {board = Array.new(10) {Array.new(10, ".")}}
  

  describe '.prompt' do
    before do 
      allow(io).to receive(:puts)
      allow(io).to receive(:gets).and_return("Rita")
    end
    it {expect(terminal.prompt("What is your name?")).to eq "Rita"}
  end

  describe '.display' do
      before {expect(io).to receive(:puts).with("Hello")}
      it {terminal.display("Hello")}
  end

  describe '.swap_players' do
    before do
      expect(io).to receive(:puts).with(".\n"*50).ordered 
    end
    it {terminal.swap_players(nil)}
  end

  describe '.enter_to_continue' do
    before do
      expect(io).to receive(:puts).with("Hello!\nPress enter to continue.")
      expect(io).to receive(:gets).and_return("")
    end
    it {terminal.enter_to_continue("Hello!")}
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
     get_row_col
    end
    it {expect(terminal.get_row_col(rows:10, cols:10)).to eq [8,5]}
  end

  describe '.try_again' do
    subject {terminal.try_again("Not valid")}
    it {is_expected.to eq "Not valid.\nTry again."}
  end

  describe '.print_board' do
    before do
      print_empty_board
    end
    it {terminal.print_board(empty_board)}
  end

  describe '.get_shot' do
    before do
      print_empty_board
      expect(io).to receive(:puts).with("Call your shot.").ordered
      get_row_col.ordered
    end
    it {terminal.get_shot(rows: 10, cols: 10, board:empty_board)}
  end

  describe '.hit' do
    context 'when hit' do
      before do
        print_empty_board
        expect(io).to receive(:puts).with("HIT\nPress enter to continue.")
        expect(io).to receive(:gets).and_return("")
      end
      it {terminal.hit(true, empty_board)}
    end

    context 'when miss' do
      before do
        print_empty_board
        expect(io).to receive(:puts).with("MISS\nPress enter to continue.")
        expect(io).to receive(:gets).and_return("")
      end
      it {terminal.hit(false, empty_board)}
    end
  end

  describe '.end' do
    context 'when player 1 wins' do
      before do
        expect(io).to receive(:puts).with("Player 1, YOU WON!")
        print_empty_board
      end
      it {terminal.end(1, empty_board)}
    end

    context 'when player 2 wins' do
      before do
        expect(io).to receive(:puts).with("Player 2, YOU WON!")
        print_empty_board
      end
      it {terminal.end(2, empty_board)}
    end
  end

end

def print_empty_board 
  expect(io).to receive(:puts).with("\n").ordered
  expect(io).to receive(:puts).with(". . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .")
  expect(io).to receive(:puts).with("\n").ordered
end

def get_row_col
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