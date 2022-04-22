class PassengerTrain < Train
  attr_reader :number

  def initialize(number, type = :passenger)
    super
  end
end
