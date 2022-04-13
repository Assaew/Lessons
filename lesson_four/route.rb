class Route
  attr_reader :start_station, :last_station, :middle_stations

  def initialize(start_station, last_station)
    @start_station = start_station
    @last_station = last_station
    @middle_stations = []
  end

  def add_station(station)
    @middle_stations << station unless @middle_stations.include?(station)
  end

  def del_station(station)
    @middle_stations.delete(station) if @middle_stations.include?(station)
  end

  def stations
    [@start_station, @middle_stations, @last_station].flatten
  end
end
