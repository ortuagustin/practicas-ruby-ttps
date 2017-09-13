require_relative 'ejercicio13_impl'
require 'minitest/autorun'
require 'minitest/unit'

class TestGenericRot < MiniTest::Test
  def test_rot_empty_string
    expected = ''
    actual = rot '', 0
    assert_equal expected, actual
  end

  def test_rot_13_sample
    expected = '¡Ovrairavqbf n yn phefnqn 2015 qr GGCF Bcpvóa Ehol!'
    actual = rot '¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!', 13
    assert_equal expected, actual
  end

  def test_rot_13_hello_upper
    expected = 'UBYN'
    actual = rot 'HOLA', 13
    assert_equal expected, actual
  end

  def test_rot_13_hello_lower
    expected = 'ubyn'
    actual = rot 'hola', 13
    assert_equal expected, actual
  end

  def test_rot_13_hello_mixed
    expected = 'uBYn'
    actual = rot 'hOLa', 13
    assert_equal expected, actual
  end

  def test_rot_13_cipher_decipher
    expected = 'hOLa'
    actual = rot 'hOLa', 13
    assert_equal expected, rot(actual, 13)
  end

  def test_rot_5_hello
    expected = 'mtqf'
    actual = rot 'hola', 5
    assert_equal expected, actual
  end

  def test_rot_17_hello
    expected = 'yfcr'
    actual = rot 'hola', 17
    assert_equal expected, actual
  end
end