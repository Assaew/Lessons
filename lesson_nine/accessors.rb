module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}"
      var_name_history = "@#{name}_history"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        history_array = instance_variable_get(var_name_history) || []
        last_history = instance_variable_get(var_name)
        if last_history
          instance_variable_set(var_name_history, history_array << last_history)
        else
          instance_variable_set(var_name_history, history_array)
        end
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history".to_sym) { puts instance_variable_get(var_name_history).to_s }
    end
  end

  def strong_attr_accessor(name, _class)
    var_name = "@#{name}"
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Введенный тип не совпадает' unless value.is_a?(_class)

      instance_variable_set(var_name, value)
    end
  end
end
