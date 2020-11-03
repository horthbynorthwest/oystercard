class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journey_history

  def initialize
  @balance = 0
  @entry_station = nil
  @journey_history = []
  end

  def top_up(value)
    check_limit(value)
    @balance += value
  end

  def touch_in(station)
    check_for_minimum
    update_entry_station(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    update_exit_station(station)
  end

  def in_journey?
    !!@entry_station
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
    @journey_history.push({ :start => station })
  end

  def update_exit_station(station)
    @journey_history.last[:finish] = station
  end
end
