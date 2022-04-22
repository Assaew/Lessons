sides = []
3.times do
  puts 'Укажите сторону треугольника'
  sides << gets.to_f
end

return puts 'Наш треугольник равнобедренный и равностронний' if sides.uniq.length == 1

side1, side2, side3 = sides.sort

return puts 'Треугольник равнобедренный и прямоугольный' if side1 == side2 && side1**2 + side2**2 == side3**2
return puts 'Треугольник прямоугольный' if side1**2 + side2**2 == side3**2

puts 'Треугольник не прямоугольный'
