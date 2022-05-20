class Route
  include InstanceCounter
  include Validation

  validate :start_station, :type, 'Station'
  validate :last_station, :type, 'Station'

  attr_reader :start_station, :last_station, :middle_stations

  def initialize(start_station, last_station)
    @start_station = start_station
    @last_station = last_station
    @middle_stations = []
    validate!
    register_instance
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

  # def validate!
  #   return true unless stations.any? { |station| station.class != Station }
  #
  #   raise ValidationError, 'Недопустимый ввод. Укажите пожалуйста станцию'
  # end
end
