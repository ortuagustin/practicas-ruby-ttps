require 'minitest/autorun'
require 'minitest/unit'
require_relative 'ejercicio2_impl'

class TestCallSortIntegerArray < MiniTest::Test
  def test_can_call_sort_array
    input = [10, 9, 1, 2, 3, 5, 7, 8]
    expected = [1, 2, 3, 5, 7, 8, 9, 10]
    actual = ordenar_arreglo(*input)
    assert_equal expected, actual
  end
end