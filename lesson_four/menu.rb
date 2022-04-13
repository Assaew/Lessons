require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

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
        14.Выход'
      enter = gets.chomp
      if ['exit', 'stop', ''].include?(enter)
        puts 'До скорой встречи!'
        exit
      end
      case enter
      when '1'
        create_station
      when '2'
        stations
      when '3'
        create_train
      when '4'
        choose_station
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
        puts 'До скорой встречи!'
        exit
      else
        wrong_input
      end
    end
  end

  private

  def create_station
    loop do
      puts 'Введите название станции или stop для выхода в меню'
      station = gets.chomp
      menu if ['stop', ''].include?(station)
      @stations << Station.new(station)
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
        @carriages << PassengerCarriage.new
      when '2'
        @carriages << CargoCarriage.new
      when '3'
        menu
      else
        wrong_input
      end
    end
  end

  def stations
    puts 'Список станций:'
    @stations.each_index { |index| puts "#{index + 1}. #{@stations[index].station_name}" }
  end

  def trains
    puts 'Список поездов:'
    @trains.each_index { |index| puts "#{index + 1}. #{@trains[index].number} #{@trains[index].carriages}" }
  end

  def carriages
    puts 'Список вагонов:'
    @carriages.each_index { |index| puts "#{index + 1}. #{@carriages[index].type}" }
  end

  def routes
    puts 'Список маршрутов:'
    @routes.each_index { |index| puts "#{index + 1}. #{@routes[index].stations}" }
  end

  def choose_station
    station = input_station
    if station <= @stations.size && station.positive?
      puts @stations[station - 1].trains.to_s
    else
      wrong_input
    end
  end

  def wrong_input
    puts 'Вы ввели некорректное значение.'
    menu
  end

  def create_route
    stations
    route = []
    puts 'Введите начальную и конечную станцию'
    2.times do
      route << gets.chomp.to_i
    end
    start_station, last_station = route
    if start_station <= @stations.size && start_station.positive? && last_station <= @stations.size && last_station.positive? && start_station != last_station
      @routes << Route.new(@stations[start_station - 1], @stations[last_station - 1])
      routes
    else
      wrong_input
    end
  end

  def change_station_in_route
    route = input_route
    station = input_station
    if route <= @routes.size && route.positive? && station <= @stations.size && station.positive?
      puts 'Что сделать со станцией?
      1. Добавить станцию
      2. Удалить станцию'
      decision = gets.chomp
      case decision
      when '1'
        @routes[route - 1].add_station(@stations[station - 1])
      when '2'
        @routes[route - 1].del_station(@stations[station - 1])
      else
        wrong_input
      end
    else
      wrong_input
    end
  end

  def assign_route
    train = input_train
    route = input_route
    if train <= @trains.size && train.positive? && route <= @routes.size && route.positive?
      @trains[train - 1].route = (@routes[route - 1])
      routes
    else
      wrong_input
    end
  end

  def input_train
    trains
    puts 'Выберите поезд'
    gets.chomp.to_i
  end

  def input_carriage
    carriages
    puts 'Выберите вагон'
    gets.chomp.to_i
  end

  def input_route
    routes
    puts 'Выберите маршрут'
    gets.chomp.to_i
  end

  def input_station
    stations
    puts 'Выберите станцию'
    gets.chomp.to_i
  end

  def move_train
    train = input_train
    if train <= @trains.size && train.positive?
      puts 'Выберите направление
            1. Вперед
            2. Назад'
      choice = gets.chomp
      case choice
      when '1'
        @trains[train - 1].move_next_station
      when '2'
        @trains[train - 1].move_previous_station
      else
        wrong_input
      end
    else
      wrong_input
    end
  end

  def change_carriage
    train = input_train
    carriage = input_carriage
    wrong_input if ''.include?(carriage.to_s)
    if train <= @trains.size && train.positive? && carriage <= @carriages.size && carriage.positive?
      puts 'Выберите действие:
            1. Присоединить вагон
            2. Отсоединить вагон'
      choice = gets.chomp
      case choice
      when '1'
        @trains[train - 1].attach_carriage(@carriages[carriage - 1])
      when '2'
        @trains[train - 1].detach_carriage(@carriages[carriage - 1])
      else
        wrong_input
      end
    else
      wrong_input
    end
  end
end

#   - Создавать станции +
#   - Создавать поезда +
#   - Создавать маршруты и управлять станциями в нем (добавлять, удалять) +
#   - Назначать маршрут поезду +
#   - Добавлять вагоны к поезду +
#   - Отцеплять вагоны от поезда +
#   - Перемещать поезд по маршруту вперед и назад +
#   - Просматривать список станций и список поездов на станции +
