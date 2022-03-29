line = []
basket = {}
loop do
  amount_h = {}
  puts "Enter the name of the product"
  product_name = gets.chomp
  break if product_name == "stop"
  puts "Enter the price"
  price =  gets.to_i
  puts "Enter the amount of the product"
  amount = gets.to_f
  basket[product_name] = {price: price, amount: amount, sum: (price * amount).round(2)}
  end
puts "The basket: #{basket}"
total = 0
basket.values.map do |hash|
  total += hash[:sum]
end
puts "Total: #{total}" 