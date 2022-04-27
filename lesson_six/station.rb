class Station
  include InstanceCounter
  include Validate
  attr_reader :trains, :name

  NAME_FORMAT = /^\w+$/

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def self.all
    @@stations
  end

  def arrive(train)
    @trains << train unless @trains.include?(train)
  end

  def departed(train)
    @trains.delete(train) if @trains.include?(train)
  end

  protected

  def validate!
    raise 'Номер не может быть пустым' if name.nil?
    raise 'Допустимый формат: буквы, цифры и _' if name !~ NAME_FORMAT

    true
  end
end
