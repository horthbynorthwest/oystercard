class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :journey_history

  def initialize
  @balance = 0
  @journey_history = []
  @journey
  end

  def top_up(value)
    check_limit(value)
    @balance += value
  end

  def touch_in(station)
    check_for_minimum
    @journey = Journey.new(station)
    # update_entry_station(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    # update_exit_station(station)
    @journey_history << @journey
  end

  # def in_journey?
  #   !!@entry_station
  #   # above is the equivalent of != nil
  # end

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

#   def update_entry_station(station)
#     @entry_station = station
#     @journey_history.push({ :start => station })
#   end
#
#   def update_exit_station(station)
#     @journey_history.last[:finish] = station
#   end
end
