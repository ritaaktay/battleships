class Game
  def initialize(player_1, player_2)
    @player_1, @player_2 = player_1, player_2
  end

  def run
    loop do
      shoot(@player_1)
      shoot(@player_2)
      return {name: @player_2.name, board: @player_2.opp_board} if @player_1.lost?
      return {name: @player_1.name, board: @player_1.opp_board} if @player_2.lost?
    end
  end

  def shoot(player)
    input_getter = ValidInputGetter.new(board: player.opp_board)
    row, col = input_getter.get_shot
    player.shoot(row, col)
  end
end