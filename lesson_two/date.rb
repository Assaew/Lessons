date = []
puts "Введите день, месяц(числом), год"
3.times do
  date << gets.chomp.to_i
end
day, month, year = date
feb = year % 400 == 0 || year % 4 == 0 && year % 100 != 0 ? 29 : 28
puts "Порядковый номер даты: #{[31, feb, 31, 30, 31, 30, 31, 31, 30 ,31, 30, 31].first(month-1).sum(day)}"