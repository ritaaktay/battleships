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


#consolidate io and display formatter?
#maybe another class output that has a formatter & io inside it
#and another class input that has a formatter & io inside it
#then valid input getter and user interface both use output & input

#look at all comments
#check yor syntax
#make class diagram
#test your logic

#send to kay
