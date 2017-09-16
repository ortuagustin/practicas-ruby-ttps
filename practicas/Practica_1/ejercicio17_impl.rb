class Integer
  def divisible_by? number
    self.modulo(number).zero?
  end

  def divisible_by_any? numbers
    numbers.any? { |x| self.divisible_by? x }
  end
end

def numbers_divisible_by divisors, limit
  Enumerator.new do |yielder|
    current = 0
    loop do
      break if current == limit
      current += 1
      yielder.yield current if current.divisible_by_any? divisors
    end
  end
end
