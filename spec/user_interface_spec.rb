require "user_interface"

RSpec.describe UserInterface do
  describe "ship setup scenario" do
    it "allows the user to set up valid ships" do
      io, game = double(:io), double(:game)
      interface = UserInterface.new(io, game)
      expect(io).to receive(:puts).with("Welcome to the game!")
      expect(io).to receive(:puts).with("Set up your ships first.")
      expect(game).to receive(:unplaced_ships).and_return([5,2])
      expect(io).to receive(:puts).with("You have these ships remaining: 5, 2")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(game).to receive(:unplaced_ships).and_return [5,2]
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("v\n")
      expect(io).to receive(:puts).with("Which row?")
      expect(io).to receive(:gets).and_return("3\n")
      expect(io).to receive(:puts).with("Which column?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(game).to receive(:check_index).with(col:1,row:2,ship:2,dir:"v").and_return(true)
      expect(io).to receive(:puts).with("OK.")
      expect(game).to receive(:place_ship).with({
        ship: 2,
        dir: "v",
        row: 2,
        col: 1
      })
      expect(io).to receive(:puts).with("This is your board now:")
      board = Array.new(10) {Array.new(10, ".")}
      board[2][1] = "S"
      board[3][1] = "S"
      expect(game).to receive(:board).and_return(board)
      expect(io).to receive(:puts).with([
        ". . . . . . . . . .",
        ". . . . . . . . . .",
        ". S . . . . . . . .",
        ". S . . . . . . . .",
        ". . . . . . . . . .",
        ". . . . . . . . . .",
        ". . . . . . . . . .",
        ". . . . . . . . . .",
        ". . . . . . . . . .",
        ". . . . . . . . . ."
      ].join("\n"))
      interface.run
    end
  end
end
