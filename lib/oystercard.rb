class Oystercard
  attr_reader :balance

  def initialize
  @balance = 0
  end

  def top_up(value)
    fail "Top up limit reached" if (@balance + value) > 90
    @balance += value
  end
end
