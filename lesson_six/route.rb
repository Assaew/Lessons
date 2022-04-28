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
    if @start_station.class != Station || @last_station.class != Station
      raise ValidationError, 'Недопустимый ввод. Укажите пожалуйста станцию'

      true
    end
  end
end
