class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
  @balance = 0
  @in_use = false
  end

  def top_up(value)
    check_limit(value)
    @balance += value
  end

  def touch_in
    check_for_minimum
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(value)
    @balance -= value
  end

  def check_for_minimum
    fail 'Insufficent Funds' if @balance < MINIMUM_FARE
  end

  def check_limit(value)
    fail "Top up limit reached" if (@balance + value) > MAXIMUM_BALANCE
  end
end
