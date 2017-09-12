require_relative 'ejercicio12_impl'
require 'minitest/autorun'
require 'minitest/unit'

class TestRot13 < MiniTest::Test
  def test_empty_string
    expected = ''
    actual = rot13 ''
    assert_equal expected, actual
  end

  def test_sample
    expected = '¡Ovrairavqbf n yn phefnqn 2015 qr GGCF Bcpvóa Ehol!'
    actual = rot13 '¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!'
    assert_equal expected, actual
  end

  def test_hola
    expected = 'UBYN'
    actual = rot13 'HOLA'
    assert_equal expected, actual
  end
end