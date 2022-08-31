$LOAD_PATH << "lib"
require "game"
require "player"
require "terminal_io"

game = Game.new(
  io: TerminalIO.new, 
  player: Player, 
  rows: 10,
  cols: 10,
  ships: [5,4,3,3,2]
)
game.run
