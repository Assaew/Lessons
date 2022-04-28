class Carriage
  include Company
  include Validatable
  attr_reader :type

  TYPES = %i[cargo passenger]

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise ValidationError, 'Тип не может быть пустым' if type.nil?
    raise ValidationError, 'Тип неправильного формата' unless TYPES.include?(type)

    true
  end
end
