class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @complete = false
  end

  def fare
   !complete? ? PENALTY_FARE : MINIMUM_FARE
  end

  def finish(station)
    @complete = true
    @exit_station = station
  end

  def complete?
    @complete
  end
end
