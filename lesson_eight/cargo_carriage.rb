class CargoCarriage < Carriage
  attr_reader :taken_volume, :volume

  VOLUME_FORMAT = /^[0-9]+$/

  def initialize(volume)
    @volume = volume
    @taken_volume = 0
    validate!
    super(:cargo)
  end

  def increase_volume=(volume)
    raise ValidationError, 'Объем не может быть пустым или отрицательным' unless volume.positive?

    if volume <= @volume - @taken_volume
      @taken_volume += volume
    else
      raise ValidationError, "Не хватает объема для увеличения на #{volume} л."
    end
  end

  def free_volume
    @volume - @taken_volume
  end

  def validate!
    raise ValidationError, 'Объем не может быть пустым' if @volume.nil?
    raise ValidationError, 'Недопустимый формат. Введите число' if @taken_volume.to_s !~ VOLUME_FORMAT
    raise ValidationError, 'Недопустимый формат. Введите объем вагона' if @volume.to_s !~ VOLUME_FORMAT

    true
  end
end
