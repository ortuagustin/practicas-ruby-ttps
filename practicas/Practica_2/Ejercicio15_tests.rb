require 'minitest/autorun'
require 'minitest/unit'
require_relative 'Ejercicio15_impl'

class Greeter
  include Countable

  def hi
    puts 'Hey!'
  end

  def bye
    puts 'See you!'
  end

  count_invocations_of :hi
end

class TestCountable < MiniTest::Test
  def test_non_hooked_method_call_count_is_zero
    sut = Greeter.new
    sut.bye
    sut.bye
    sut.bye
    assert_equal 0, sut.invoked(:bye)
  end

  def test_non_hooked_method_was_never_called
    sut = Greeter.new
    sut.bye
    sut.bye
    sut.bye
    refute sut.invoked?(:bye)
  end

  def test_hooked_method_call_count
    sut = Greeter.new
    sut.hi
    sut.bye
    sut.hi
    assert_equal 2, sut.invoked(:hi)
  end

  def test_hooked_method_was_called
    sut = Greeter.new
    sut.hi
    assert sut.invoked?(:hi)
  end
end