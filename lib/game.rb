class Game
  def initialize(player_1, player_2)
    @player_1, @player_2 = player_1, player_2
    @input_getter = ValidInputGetter.new()
  end

  def player_1_shoots
    shoot(@player_1)
  end

  def player_2_shoots
    shoot(@player_2)
  end

  def end?
    @player_1.lost? || @player_2.lost?
  end

  def winner
    return {name: @player_2.name, board: @player_2.opp_board} if @player_1.lost?
    return {name: @player_1.name, board: @player_1.opp_board} if @player_2.lost?
  end

  private

  def shoot(player)
    row, col = input_getter.get_shot(player.opp_board)
    player.shoot(row, col)
  end
end