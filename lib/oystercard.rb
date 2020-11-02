class Oystercard
  MAXIMUM_BALANCE = 90
  
  attr_reader :balance

  def initialize
  @balance = 0
  end

  def top_up(value)
    fail "Top up limit reached" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end
end
