months_hash = {January:31, Fabuary:28, Marth:31, April:30, May:31, June:30, July:31, August:31, September:30, October:31, November:30, December:31}
months_hash.each do |month, days|
  if days == 30 
    puts "#{month}"
  end
end