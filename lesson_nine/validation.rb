module Validation
  def validate(name, *args)
    variable = instance_variable_get("@#{name}")
    case args[0]
    when :presence
      define_method(validate!) do
        raise ValidationError, 'Имя не может быть пустым' if variable.nil? || variable == ''

        true
      end
    when :format
      define_method(validate!) do
        raise ValidationError, 'Имя не соотвествует формату' if variable !~ args[1]

        true
      end
    when :type
      define_method(validate!) do
        raise ValidationError, 'Тип неправильного формата' unless variable.instance_of?(args[1])

        true
      end
    else raise 'Тип валидации указан неверно'
    end

    define_method(valid?) do
      validate!
    rescue ValidationError
      false
    end
  end
end
