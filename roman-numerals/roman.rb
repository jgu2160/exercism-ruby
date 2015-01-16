ROMAN_HASH = {I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000}

public

def to_roman
  n = self
  digit_array = n.to_s.split('').map { |digit| digit.to_i }.reverse
  the_roman = ""
  digit_array.map.each_with_index do |digit, index|
    digit.digitize(1 * 10 ** index, 5 * 10 ** index, 10 * 10 ** index) 
  end
  if n < 100
    tens, ones = n.divmod(10)
    if tens == 0
      the_roman += ones.digitize(1, 5, 10)
    else
      the_roman += tens.digitize(10, 50, 100)
      the_roman += ones.digitize(1, 5, 10)
    end
  end
end

def digitize(one, five, ten)
  digit = self 
  if digit < 4
    digit.single_make(one)
  elsif digit == 5
    1.single_make(five)
  elsif digit == 9
    9.surround_x(ten, one)
  else 
    digit.surround_x(five, one)
  end
end

def single_make(single_type)
  n = self
  ROMAN_HASH.key(single_type).to_s * n
end

def surround_x(x, surrounder)
  n = self
  diff = n - x
  if diff == -1
    1.single_make(surrounder) + 1.single_make(x)
  else 
    1.single_make(x) + diff.single_make(surrounder)
  end
end
