require 'game'

RSpec.describe Game do
  let(:player1) {double(:player1)}
  let(:player2) {double(:player2)}
  let(:terminal_io) {double(:terminal_io)}
  let(:game) {Game.new(
    player1: player1, 
    player2:player2, 
    io: terminal_io,
    ships: [5,4,3,3,2],
    rows: 10,
    cols:10,
    ) 
  }

  describe '.initialize' do
    it {expect(game).to be}
  end

  describe '.run' do
    before do 
      expect(terminal_io).to receive(:start).ordered
      #ship placement 
      expect(terminal_io). to receive(:swap_players).ordered
    end
    it {game.run}
  end
end