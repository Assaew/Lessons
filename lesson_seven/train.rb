class Train
  include Company
  include InstanceCounter
  include Validatable
  attr_reader :current_speed, :carriages, :type
  attr_accessor :number

  NUMBER_FORMAT = /^[a-zA-Z0-9]{3}-*[a-zA-Z0-9]{2}$/
  TYPES = %i[cargo passenger]
  @@trains = {}

  def self.find(number)
    @@trains[number] if @@trains.include?(number)
  end

  def initialize(number, type)
    @current_speed = 0
    @number = number
    @type = type
    @carriages = []
    @@trains[number] = self
    register_instance
    validate!
  end

  def increase_speed
    @current_speed += 1
  end

  def stop
    @current_speed = 0
  end

  def attach_carriage(carriage)
    if wrong_carriage_type?(carriage)
      puts 'Тип вагона не соответсвует типу поезда или поезд в пути'
    else
      return puts 'Такой вагон уже присутствует' if carriages.include?(carriage)

      carriages << carriage
    end
  end

  def detach_carriage(carriage)
    if wrong_carriage_type?(carriage)
      puts 'Тип вагона не соответсвует типу поезда или поезд в пути'
    else
      return 'Такого вагона нет в списке' unless carriages.include?(carriage)

      carriages.delete(carriage)
    end
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station.arrive(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def move_next_station
    return unless next_station

    current_station.departed(self)
    next_station.arrive(self)
    @current_station_index += 1
  end

  def move_previous_station
    return unless previous_station

    current_station.departed(self)
    previous_station.arrive(self)
    @current_station_index -= 1
  end

  protected # Нужны только для логики перемещения на следующую и предыдущую станцию. Пользователю не нужен доступ к ним.

  def validate!
    raise ValidationError, 'Номер не может быть пустым' if number.nil?
    raise ValidationError, 'Тип не может быть пустым' if type.nil?

    if number !~ NUMBER_FORMAT
      raise ValidationError,
            'Недопустимый формат. Tри буквы или цифры, необязательный дефис, 2 буквы или цифры'
    end
    raise ValidationError, 'Тип неправильного формата' unless TYPES.include?(type)

    true
  end

  def wrong_carriage_type?(carriage)
    carriage.type != type || @current_speed != 0
  end

  def previous_station
    @route.stations[@current_station_index - 1] unless @current_station_index.zero?
  end

  def next_station
    @route.stations[@current_station_index + 1] unless @current_station_index == @route.stations.count - 1
  end
end
