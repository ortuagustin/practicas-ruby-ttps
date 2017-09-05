require_relative 'ejercicio5_impl.rb'
require 'minitest/autorun'
require 'minitest/unit'

class TestContar < MiniTest::Test
  def test_contar_empty
    expected = 0
    actual = ContarPalabras.contar '', ''
    assert_equal expected, actual
  end

  def test_contar_is_case_insensitive
    expected = 1
    actual = ContarPalabras.contar 'A', 'a'
    assert_equal expected, actual
  end

  def test_contar_substr_multiple_times
    expected = 2
    actual = ContarPalabras.contar 'a a', 'a'
    assert_equal expected, actual
  end

  def test_contar_sample
    expected = 5
    actual = ContarPalabras.contar 'La casa de la esquina tiene la puerta roja y la ventana blanca.', 'la'
    assert_equal expected, actual
  end
end