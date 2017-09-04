require_relative 'ejercicio4_impl.rb'
require 'minitest/autorun'
require 'minitest/unit'

class TestHoraEnPalabras < MiniTest::Test
  def create_time  hour, min
    Time.new 2017, 1, 1, hour, min
  end

  def test_en_punto
    expected = 'Son las 10 en punto'
    actual = Hora.en_palabras create_time 10, 1
    assert_equal expected, actual 
  end

  def test_y_cuarto
    expected = 'Son las 9 y cuarto'
    actual = Hora.en_palabras create_time 9, 18
    assert_equal expected, actual 
  end

  def test_y_media
    expected = 'Son las 9 y media'
    actual = Hora.en_palabras create_time 9, 33
    assert_equal expected, actual 
  end

  def test_menos_cuarto
    expected = 'Son las 10 menos cuarto'
    actual = Hora.en_palabras create_time 9, 45
    assert_equal expected, actual 
  end

  def test_casi_la_hora
    expected = 'Casi son las 7'
    actual = Hora.en_palabras create_time 6, 58
    assert_equal expected, actual 
  end
end