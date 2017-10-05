require 'minitest/autorun'
require 'minitest/unit'
require_relative 'ejercicio1_impl'

class TestSortIntegerArray < MiniTest::Test
  def test_sort_unsorted_integer_array
    expected = [0, 1, 2, 3, 4, 6, 10]
    actual = ordenar_arreglo([1, 4, 6, 2, 3, 0, 10])
    assert_equal expected, actual
  end

  def test_sort_empty_array
    expected = []
    actual = ordenar_arreglo([])
    assert_equal expected, actual
  end

  def test_sort_sorted_integer_array
    expected = [1, 2, 3, 4]
    actual = ordenar_arreglo([1, 2, 3, 4])
    assert_equal expected, actual
  end
end