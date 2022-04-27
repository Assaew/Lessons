class Carriage
  include Company
  include Validate
  attr_reader :type

  TYPES = %i[cargo passenger]

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise 'Тип не может быть пустым' if type.nil?
    raise 'Тип неправильного формата' unless TYPES.include?(type)

    true
  end
end