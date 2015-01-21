ROMAN_HASH = {I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000}

public

def to_roman
  digit_array = self.split_and_reverse
  digit_array.map.each_with_index(&romanizing_block).reverse.join
end

def split_and_reverse
  self.to_s.split('').map { |digit| digit.to_i }.reverse
end

def romanizing_block
  Proc.new {|digit, index| digit.categorize_digit_with_magnitude(1 * 10 ** index, 5 * 10 ** index, 10 * 10 ** index)} 
end

def categorize_digit_with_magnitude(one, five, ten)
  digit = self 
  if digit < 4 then digit.make_single_numeral(one)
  elsif digit == 5 then 1.make_single_numeral(five)
  elsif digit == 9 then 9.surround_x(ten, one)
  else digit.surround_x(five, one)
  end
end

def make_single_numeral(single_type)
  ROMAN_HASH.key(single_type).to_s * self
end

def surround_x(x, surrounder)
  diff = self * surrounder - x
  diff_digits = diff.to_s.split('').map {|d| d.to_i}
  if diff < 0
    1.make_single_numeral(surrounder) + 1.make_single_numeral(x)
  else 
    1.make_single_numeral(x) + diff_digits[0].make_single_numeral(surrounder)
  end
end
