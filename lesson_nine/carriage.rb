class Carriage
  include Company
  include Validation
  attr_reader :type

  TYPES = %i[cargo passenger]

  validate :type, :format, TYPES
  validate :type, :presence
  validate :type, :type, 'Symbol'

  def initialize(type)
    @type = type
    validate!
  end

  protected

  # def validate!
  #   raise ValidationError, 'Тип не может быть пустым' if type.nil?
  #   raise ValidationError, 'Тип неправильного формата' unless TYPES.include?(type)
  #
  #   true
  # end
end
