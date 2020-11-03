class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
  @balance = 0
  @in_use = false
  @entry_station = nil
  end

  def top_up(value)
    check_limit(value)
    @balance += value
  end

  def touch_in(station)
    check_for_minimum
    @in_use = true
    update_entry_station(station)
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

  def update_entry_station(station)
    @entry_station = station
  end
end
