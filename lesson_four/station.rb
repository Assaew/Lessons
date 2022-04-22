class Station
  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train unless @trains.include?(train)
  end

  def departed(train)
    @trains.delete(train) if @trains.include?(train)
  end

  # def train_list_type(type)
  #   found_trains = @trains.find_all {|train| train.type == type}
  #   puts "Количество #{type} поездов: #{found_trains.length}."
  #   found_trains
  # end
end
