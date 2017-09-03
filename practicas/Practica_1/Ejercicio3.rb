# Escribí una función llamada reemplazar que reciba un String y que busque y reemplace en el mismo cualquier ocurrencia de
# { por do\n y cualquier ocurrencia de } por \nend, de modo que convierta los bloques escritos con llaves por bloques
# multilínea con do y end.
# Por ejemplo:
#   reemplazar('3.times { |i| puts i }') => '3.times do\n |i| puts i \nend'

require_relative 'Ejercicio3_reemplazar'
require 'minitest/autorun'
require 'minitest/unit'

class TestReemplazar < MiniTest::Test
  def test_reemplazar_string_vacio
    actual = Reemplazar.reemplazar ""
    assert_equal("", actual)
  end

  def test_reemplazar_llave_apertura
    expected = "do\n"
    actual = Reemplazar.reemplazar "{"
    assert_equal(expected, actual)
  end

  def test_reemplazar_llave_cierre
    expected = "\nend"
    actual = Reemplazar.reemplazar "}"
    assert_equal(expected, actual)
  end

  def test_reemplazar_llaves_cierre_y_apertura
    expected = "do\n \nend"
    actual = Reemplazar.reemplazar "{ }"
    assert_equal(expected, actual)
  end

  def test_reemplazar_bloque
    expected = "3.times do\n |i| puts i \nend"
    actual = Reemplazar.reemplazar("3.times { |i| puts i }") 
    assert_equal(expected, actual)
  end
end
