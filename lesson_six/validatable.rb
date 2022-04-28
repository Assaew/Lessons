module Validatable
  def valid?
    validate!
  rescue ValidationError
    false
  end

  def validate!
    raise 'not implemented'
  end
end
