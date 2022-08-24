$LOAD_PATH << "lib"
require "game"
require "user_interface"
require "terminal_io"

ships = [5,4,3,3,2]
game = Game.new(ships: ships, rows: 10, cols: 10)
user_interface = UserInterface.new(game, TerminalIO.new)
user_interface.run
