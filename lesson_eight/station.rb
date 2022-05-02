class Station
  include InstanceCounter
  include Validatable
  attr_reader :trains, :name

  NAME_FORMAT = /^\w+$/

  @@stations = []

  def initialize(name)
    @name = name.capitalize
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

  def trains_block(&block)
    @trains.each.with_index(1) { |train, index| block.call(train, index) }
  end

  protected

  def validate!
    raise ValidationError, 'Номер не может быть пустым' if name.nil?
    raise ValidationError, 'Недопустимый формат. Латинские буквы, цифры и _' if name !~ NAME_FORMAT

    true
  end
end
