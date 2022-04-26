class CargoCarriage
  include Company
  attr_reader :type

  def initialize
    @type = :cargo
  end
end
