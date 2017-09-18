require 'minitest/autorun'
require 'minitest/unit'
require_relative 'ejercicio18_impl'

class TestFibonacciGenerator < MiniTest::Test
  def test_fibonacci_up_to_1
    expected = [0]
    actual = fibonacci.first(1)
    assert_equal expected, actual
  end

  def test_fibonacci_up_to_2
    expected = [0, 1]
    actual = fibonacci.first(2)
    assert_equal expected, actual
  end

  def test_fibonacci_up_to_10

    expected = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    actual = fibonacci.first(10)
    assert_equal expected, actual
  end

  def test_fibonnaci_even_numbers
    expected = [0, 2, 8, 34, 144]
    actual = fibonacci.select(& :even?).first(5)
    assert_equal expected, actual
  end

  def test_fibonnaci_sum_of_nth_even_numbers
    expected = [0, 2, 8, 34].sum
    actual = fibonacci.take_while{ |x| x < 100 }.select(& :even?).sum
    assert_equal expected, actual
  end
end

