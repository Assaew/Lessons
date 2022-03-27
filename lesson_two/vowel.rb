alphabet_array = ("a".."z").to_a
alphabet_hash = {}
letter_array = ["a", "e", "i", "o", "u", "y"]
alphabet_array.each do |vowel|
  if letter_array.include?(vowel) 
    alphabet_hash.store(vowel, alphabet_array.index(vowel) + 1)
  end
end
puts "#{alphabet_hash}"