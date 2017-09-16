require 'minitest/autorun'
require 'minitest/unit'
require_relative 'ejercicio17_impl'

class TestSumOfNumbersDivisibleBy < MiniTest::Test
  def test_sum_limit_0
    expected = 0
    actual = (numbers_divisible_by [3, 5], 0).sum
    assert_equal expected, actual
  end

  def test_sum_limit_3
    expected = 3
    actual = (numbers_divisible_by [3, 5], 3).sum
    assert_equal expected, actual
  end

  def test_sum_limit_5
    expected = [3, 5].sum
    actual = (numbers_divisible_by [3, 5], 5).sum
    assert_equal expected, actual
  end

  def test_sum_limit_15
    expected = [15, 12, 10, 9, 6, 5, 3].sum
    actual = (numbers_divisible_by [3, 5], 15).sum
    assert_equal expected, actual
  end
end