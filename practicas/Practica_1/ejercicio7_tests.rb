require 'minitest/autorun'
require 'minitest/unit'

class TestOperacionesString < MiniTest::Test
  def test_print_reverse_string
    expected = 'aloh'
    actual = 'hola'.reverse
    assert_equal expected, actual
  end

  def test_delete_whitespace
    expected = 'holaMundo'
    actual = ' hola Mundo '.delete ' '
    assert_equal expected, actual
  end

  def test_chars_to_ascii
    expected = [72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]
    actual = 'Hello world'.codepoints
    assert_equal expected, actual
  end


  def test_vowels_to_numbers
    expected = '43106'
    actual = 'aeiou'.downcase.gsub(
        /[aeiou]/,
        'a' => '4',
        'e' => '3',
        'i' => '1',
        'o' => '0',
        'u' => '6')

    assert_equal expected, actual
  end
end