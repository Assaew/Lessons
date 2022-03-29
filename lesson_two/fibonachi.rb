fibs = [0,1]
fib_sum = 0
while fib_sum <= 100 do
  fib_sum = fibs[-2] + fibs[-1]
  fibs << fib_sum
  end
fibs.delete_at(-1)
puts "#{fibs}"
