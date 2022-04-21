class Route
  attr_reader :start_station, :last_station, :middle_stations

  def initialize(start_station, last_station)
    @start_station = start_station
    @last_station = last_station
    @middle_stations = []
  end

  def add_station(station)
    if stations.include?(station)
      puts 'Такая станция уже присутсвует в маршруте'
    else
      @middle_stations << station
    end
  end

  def del_station(station)
    if stations.include?(station)
      @middle_stations.delete(station)
    else
      puts 'Такой станции нет в маршруте'
    end
  end

  def stations
    [@start_station, @middle_stations, @last_station].flatten
  end

  def show
    puts (stations.each { |station| puts station.name }).to_s
  end
end
