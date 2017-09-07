require_relative 'ejercicio10_impl'
require 'minitest/autorun'
require 'minitest/unit'

class TestArrayOfStringLength < MiniTest::Test
  def test_empty_array
    expected = []
    actual =  longitud []
    assert_equal expected, actual
  end

  def test_sample_array
    expected = [4, 6, 4, 12]
    actual =  longitud(['TTPS', 'Opción', 'Ruby', 'Cursada 2017'])
    assert_equal expected, actual
  end
end