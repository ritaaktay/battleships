require "user_interface"

RSpec.describe UserInterface do
  xit "allows the user to set up valid ships" do
    io, game = double(:io), double(:game)
    interface = UserInterface.new(io, game)
    expect(io).to receive(:start)

    expect(game).to receive(:check_index).with(col:1,row:2,ship:2,dir:"v").and_return(true)
    expect(game).to receive(:place_ship).with({
      ship: 2,
      dir: :vertical,
      row: 2,
      col: 1
    })

      # ". . . . . . . . . .",
      # ". . . . . . . . . .",
      # ". S . . . . . . . .",
      # ". S . . . . . . . .",
      # ". . . . . . . . . .",
      # ". . . . . . . . . .",
      # ". . . . . . . . . .",
      # ". . . . . . . . . .",
      # ". . . . . . . . . .",
      # ". . . . . . . . . ."
    interface.run
  end
end

