require_relative 'ejercicio11_impl'
require 'minitest/autorun'
require 'minitest/unit'

class TestHashToHtmlList < MiniTest::Test
  def test_empty_hash
    expected = '<ul></ul>'
    actual = a_ul ( {} )
    assert_equal expected, actual
  end

  def test_one_element_hash
    expected = '<ul><li>perros: 1</li></ul>'
    actual = a_ul ({ "perros": '1'})
    assert_equal expected, actual
  end

  def test_sample_hash
    expected = '<ul><li>perros: 1</li><li>gatos: 1</li><li>peces: 0</li></ul>'
    actual = a_ul ({ "perros": '1', "gatos": '1', "peces": '0' })
    assert_equal expected, actual
  end
end