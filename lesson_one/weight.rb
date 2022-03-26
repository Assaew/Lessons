puts "Как Вас зовут?"
name = gets.chomp
puts "Какой Ваш рост?"
high = gets.chomp.to_i
ideal_weight = (high-110)*1.15
return puts "#{name}, Ваш идеальный вес #{ideal_weight} кг" if ideal_weight > 0 
puts "#{name}, Ваш вес уже идеальный"