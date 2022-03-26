puts "Введите коэфициент a"
a = gets.chomp.to_i
puts "Введите коэфициент b"
b = gets.chomp.to_i
puts "Введите коэфициент c"
c = gets.chomp.to_i
d=(b**2-4*a*c)
return puts "Корни уровнения: #{(-b+Math.sqrt(d))/(2*a)} и #{(-b-Math.sqrt(d))/(2*a)}" if d>0
return puts "Корень уровнения: #{(-b+Math.sqrt(d))/(2*a)}" if d==0
puts "Корней нет."