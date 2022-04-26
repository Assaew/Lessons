class PassengerCarriage
  include Company
  attr_reader :type

  def initialize
    @type = :passenger
  end
end