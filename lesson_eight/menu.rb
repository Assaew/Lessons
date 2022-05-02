require_relative 'company'
require_relative 'instancecounter'
require_relative 'validatable'
require_relative 'validation_error'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class Menu
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @carriages = []
  end

  def menu
    loop do
      puts 'Выберите пункт меню:
        1.Создать станцию
        2.Список станций
        3.Создать поезд
        4.Список поездов на станции
        5.Создать маршрут
        6.Список маршрутов
        7.Изменить станцию в маршруте
        8.Назначить маршрут поезду
        9.Переместить поезд по маршруту
        10.Список поездов
        11.Создать вагон
        12.Прицепить/отцепить вагон
        13.Список вагонов
        14.Список вагонов поезда
        15.Наполнить вагон
        16.Выход'
      enter = gets.chomp
      begin
        case enter
        when '1'
          create_station
        when '2'
          stations
        when '3'
          create_train
        when '4'
          trains_on_station
        when '5'
          create_route
        when '6'
          routes
        when '7'
          change_station_in_route
        when '8'
          assign_route
        when '9'
          move_train
        when '10'
          trains
        when '11'
          create_carriage
        when '12'
          change_carriage
        when '13'
          carriages
        when '14'
          carriages_of_train
        when '15'
          fill_carriage
        when '16'
          puts 'До скорой встречи!'
          exit
        else
          wrong_input
        end
      rescue ValidationError => e
        puts e.message.to_s
        menu
      end
    end
  end

  private

  def fill_carriage
    carriage = input_carriage
    if carriage.type == :cargo
      puts 'Укажите заполняемый объем'
      carriage.increase_volume = gets.chomp.to_i
      puts "Теперь в вагоне: #{carriage.taken_volume} л."
    else
      carriage.take_a_seat
      puts "Занятых мест в вагоне: #{carriage.taken_seats}."
    end
  end

  def wrong_input
    puts 'Вы ввели некорректное значение.'
    menu
  end

  def create_station
    loop do
      puts 'Введите название станции или stop для выхода в меню'
      station = gets.chomp
      menu if ['stop', ''].include?(station)
      @stations << Station.new(station)
      stations
    end
  end

  def create_train
    loop do
      puts 'Введите название поезда или введи stop'
      train = gets.chomp
      menu if ['stop', ''].include?(train)
      puts 'Укажите тип поезда:
        1.Пассажирский
        2.Грузовой
        3.Выход в меню'
      type = gets.chomp
      case type
      when '1'
        @trains << PassengerTrain.new(train)
      when '2'
        @trains << CargoTrain.new(train)
      when '3'
        menu
      else
        wrong_input
      end
      trains
    end
  end

  def create_carriage
    loop do
      puts 'Укажите тип вагона:
        1.Пассажирский
        2.Грузовой
        3.Выход в меню'
      type = gets.chomp
      case type
      when '1'
        puts 'Введите количесво мест в вагоне'
        @carriages << PassengerCarriage.new(gets.chomp.to_i)
      when '2'
        puts 'Введите максимальный объем вагона'
        @carriages << CargoCarriage.new(gets.chomp.to_i)
      when '3'
        menu
      else
        wrong_input
      end
      carriages
    end
  end

  def create_route
    puts 'Начальная станция маршрута'
    start_station = input_station
    puts 'Конечная станция маршрута'
    last_station = input_station
    wrong_input if start_station == last_station
    @routes << Route.new(start_station, last_station)
    routes
  end

  def stations
    puts 'Список станций:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def trains
    puts 'Список поездов:'
    @trains.each.with_index(1) do |train, index|
      puts "#{index}. #{train.number}-#{train.type} (#{train.carriages.size})"
    end
  end

  def carriages
    puts 'Список вагонов:'
    @carriages.each.with_index(1) do |carriage, index|
      if carriage.type == :cargo
        puts "#{index}. #{carriage.type}[Заполено (л):#{carriage.taken_volume} из #{carriage.volume}]"
      else
        puts "#{index}. #{carriage.type}[Занято мест:#{carriage.taken_seats} из #{carriage.seats}]"
      end
    end
  end

  def routes
    puts 'Список маршрутов:'
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. #{stiled_route(route)}"
    end
  end

  def trains_on_station
    station = input_station
    block = ->(train, index) { puts "#{index}. #{train.number}" }
    puts "Поезда на станции #{station.name}:"
    station.trains_block(&block)
  end

  def carriages_of_train
    train = input_train
    block = if train.type == :cargo
              ->(carriage, index) { puts "#{index}. Грузовой. Объем:#{carriage.volume}" }
            else
              ->(carriage, index) { puts "#{index}. Пассажирский. Мест:#{carriage.seats}" }
            end
    puts "Вагоны поезда #{train.number}:"
    train.carriages_block(&block)
  end

  def change_station_in_route
    route = input_route
    station = input_station
    puts 'Что сделать со станцией?
      1. Добавить станцию
      2. Удалить станцию'
    decision = gets.chomp
    case decision
    when '1'
      route.add_station(station)
    when '2'
      route.del_station(station)
    else
      wrong_input
    end
    puts "Маршрут изменился на: #{stiled_route(route)}"
  end

  def assign_route
    train = input_train
    route = input_route
    train.route = route
    puts "Поезд #{train.number} находится на маршруте: #{stiled_route(route)}"
  end

  def stiled_route(route)
    route.stations.map(&:name).join(', ')
  end

  def input_train
    trains
    puts 'Выберите поезд'
    train_index = gets.chomp.to_i
    wrong_input if train_index > @trains.size || train_index.negative?
    @trains[train_index - 1]
  end

  def input_carriage
    carriages
    puts 'Выберите вагон'
    carriage_index = gets.chomp.to_i
    wrong_input if carriage_index > @carriages.size || carriage_index.negative?
    @carriages[carriage_index - 1]
  end

  def input_route
    routes
    puts 'Выберите маршрут'
    route_index = gets.chomp.to_i
    wrong_input if route_index > @routes.size || route_index.negative?
    @routes[route_index - 1]
  end

  def input_station
    stations
    puts 'Выберите станцию'
    station_index = gets.chomp.to_i
    wrong_input if station_index > @stations.size || station_index.negative?
    @stations[station_index - 1]
  end

  def move_train
    train = input_train
    puts 'Выберите направление
            1. Вперед
            2. Назад'
    choice = gets.chomp
    case choice
    when '1'
      train.move_next_station
    when '2'
      train.move_previous_station
    else
      wrong_input
    end
    puts "Поезд #{train.number} переместился на станцию #{train.current_station.name}"
  end

  def change_carriage
    train = input_train
    carriage = input_carriage
    puts 'Выберите действие:
            1. Присоединить вагон
            2. Отсоединить вагон'
    choice = gets.chomp.to_s
    case choice
    when '1'
      train.attach_carriage(carriage)
    when '2'
      train.detach_carriage(carriage)
    else
      wrong_input
    end
    trains
  end
end
