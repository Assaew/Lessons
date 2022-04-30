class Route
  include InstanceCounter
  include Validatable

  attr_reader :start_station, :last_station, :middle_stations

  def initialize(start_station, last_station)
    @start_station = start_station
    @last_station = last_station
    @middle_stations = []
    register_instance
    validate!
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

  def validate!
    return true if stations.map { |station| station.is_a?(Station) }.all?

    raise ValidationError, 'Недопустимый ввод. Укажите пожалуйста станцию'
  end
end
