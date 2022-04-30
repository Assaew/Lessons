class PassengerCarriage < Carriage
  attr_reader :taken_seats, :seats

  SEATS_FORMAT = /^[0-9]+$/

  def initialize(seats)
    @seats = 0
    @taken_seats = 0
    @seats = seats
    validate!
    super(:passenger)
  end

  def take_a_seat
    raise ValidationError, 'В вагоне мест больше нет' if @seats == @taken_seats

    @taken_seats += 1 if @taken_seats < @seats
  end

  def free_seats
    @seats - @taken_seats
  end

  def validate!
    raise ValidationError, 'Количество не может быть пустым' unless @seats.positive?
    raise ValidationError, 'Недопустимый формат. Введите количество мест' if @seats.to_s !~ SEATS_FORMAT

    true
  end
end
