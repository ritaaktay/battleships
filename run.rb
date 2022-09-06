$LOAD_PATH << "lib"
require "game"
require "player"
require "terminal_io"
require "board"
require "ship"
require "valid_input_getter"
require "user_interface"
require "setup"
require "display_formatter"

user_interface = UserInterface.new(
  ship_lengths: [4,2],
  board_size: 10
)
user_interface.run