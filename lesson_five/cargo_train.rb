class CargoTrain < Train
  attr_reader :number

  def initialize(number, type = :cargo)
    super
  end
end
