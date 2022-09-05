class Ship
  def initialize(length)
    @ship = Array.new(length,true)
  end

  def sunk?
    @ship.length == 0
  def

  def hit
    @ship.pop
  end
end