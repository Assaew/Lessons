class Train
  attr_reader :current_speed
  attr_reader :carriage
  attr_reader :type

  def initialize(number, type, carriage)
    @current_speed = 0
    @number = number
    @type = type
    @carriage = carriage   
  end

  def increase_speed
    @current_speed += 1
  end

  def stop
    @current_speed = 0
  end

  def decrease_carriage 
    @carriage -= 1 if @current_speed == 0 && @carriage > 0
  end

  def increase_carriage
    @carriage += 1 if @current_speed == 0 
  end

  def route=(route)
    @route = route
    @current_station_index = 0    
    current_station.arrive(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def previous_station
    @route.stations[@current_station_index-1] unless @current_station_index == 0
  end
  
  def next_station
    @route.stations[@current_station_index+1] unless @current_station_index == @route.stations.count - 1
  end

  def move_next_station
    if next_station
      current_station.departed(self)
      next_station.arrive(self)
      @current_station_index += 1
    end
  end

  def move_previous_station
    if previous_station
      current_station.departed(self)
      previous_station.arrive(self)
      @current_station_index -= 1
    end
  end
end