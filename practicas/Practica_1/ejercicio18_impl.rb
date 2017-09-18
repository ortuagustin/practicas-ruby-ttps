def fibonacci
  i = 0
  j = 1
  enum = Enumerator.new do |yielder|
    loop do
      yielder.yield i
      prior_i = i
      i = j
      j = j + prior_i
    end
  end
  enum.lazy
end