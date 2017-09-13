require_relative 'ejercicio15_impl'
require 'minitest/autorun'
require 'minitest/unit'

class TestRGBToNumbers < MiniTest::Test
  def test_notacion_hexadecimal
    expected = 0x0080FF
    actual = notacion_hexadecimal([0, 128, 255])
    assert_equal expected, actual
  end

  def test_notacion_entera
    expected = 16744448
    actual = notacion_entera([0, 128, 255])
    assert_equal expected, actual
  end
end