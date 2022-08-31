require 'game'

RSpec.describe Game do
  let(:terminal_io) {double(:terminal_io)}
  let(:player) {double(:player)}
  let(:game) {Game.new(
      io: terminal_io,
      player: player,
      ships: [5,4,3,3,2],
      rows: 10,
      cols:10,
  )}
  

  describe '.initialize' do
    before {allow(player).to receive(:new).with(hash_including(:rows, :cols, :ships)).and_return(player)}
    it {expect(game).to be}
  end

  describe '.run' do
    before do 
      #does let mean it re-initializes inside each describe block?
      allow(player).to receive(:new).with(hash_including(:rows, :cols, :ships)).and_return(player)
      expect(terminal_io).to receive(:enter_to_continue).with("Welcome to the game!\nPlayer 1, ready to place your ships?").ordered
      #ship placement 
      expect(player).to receive(:unplaced_ships).and_return([5,4,3,3,2]).twice
      expect(terminal_io).to receive(:get_ship).and_return(5)
      expect(terminal_io).to receive(:get_dir).and_return(:vertical)
      expect(terminal_io).to receive(:get_row_col).and_return([1,1])
      expect(player).to receive(:check_index).and_return(true)
      expect(player).to receive(:place_ship).with(hash_including(:ship, :dir, :row, :col))
      expect(player).to receive(:own_board)
      expect(terminal_io).to receive(:print_board)
      #no more ships
      expect(player).to receive(:unplaced_ships).and_return([])
      expect(terminal_io).to receive(:enter_to_continue).with("Your ships are ready for battle.")
      #swap players
      expect(terminal_io). to receive(:swap_players).with(message:"Player 2, ready to place your ships?")
      #ship placement
      expect(player).to receive(:unplaced_ships).and_return([5,4,3,3,2]).twice
      expect(terminal_io).to receive(:get_ship).with([5,4,3,3,2]).and_return(5)
      expect(terminal_io).to receive(:get_dir).and_return(:vertical)
      expect(terminal_io).to receive(:get_row_col).and_return([1,1])
      expect(player).to receive(:check_index).and_return(true)
      expect(player).to receive(:place_ship).with(hash_including(:ship, :dir, :row, :col))
      expect(player).to receive(:own_board)
      expect(terminal_io).to receive(:print_board)
      #no more ships
      expect(player).to receive(:unplaced_ships).and_return([])
      expect(terminal_io). to receive(:enter_to_continue).with("Your ships are ready for battle.")
      #set up done
      expect(terminal_io). to receive(:swap_players).with(message:"Take turns shooting. Player 1 starts.")
    end
    it {game.run}
  end
end