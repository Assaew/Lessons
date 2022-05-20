module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, *validation_args)
      @validations ||= {}
      validations[name] ||= []
      validations[name] << { type: validation_type, args: validation_args.first }
      define_method(:validations) { self.class.instance_variable_get('@validations') }
    end
    attr_reader :validations
  end

  module InstanceMethods
    def validate!
      return false unless validations

      validations.each do |name, args|
        args.each do |validation|
          validation_type = validation[:type]
          validation_option = validation[:args]
          send("validate_#{validation_type}", name, instance_variable_get("@#{name}"), validation_option)
        end
      end
    end

    def validate_presence(name, value, _parameter)
      raise ValidationError, "Не может быть пустым, проверь #{name}" if value.is_a?(String) && value.empty?
    end

    def validate_format(name, value, format)
      raise ValidationError, "Неверный формат, проверь #{name}" if value !~ format
    end

    def validate_type(name, value, type)
      raise ValidationError, "Неверный тип, проверь #{name}" unless value.is_a?(Object.const_get type)
    end

    def valid?
      validate!
      true
    rescue ValidationError => e
      false
      puts e
    end
  end
end
