# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/scanner.rb'

class TestScanner < Minitest::Test
  def test_character
    scanner = Scanner.new('0')

    assert_respond_to(scanner, 'character')
    assert_equal('0', scanner.character)
  end

  def test_position
    scanner = Scanner.new('0')

    assert_respond_to(scanner, 'position')
    assert_equal(0, scanner.position)
  end

  def test_ignore_single_character_source_raises_error
    scanner = Scanner.new('0')

    # Ignore (skip) the first character.
    scanner.ignore
    assert_equal('', scanner.character)
    assert_equal(1, scanner.position)
    assert_raises(EndOfInputError) { scanner.ignore }
  end

  def test_ignore_with_source
    scanner = Scanner.new('abc')

    scanner.ignore
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept
    scanner = Scanner.new('abc')

    assert_equal('a', scanner.accept('a'))
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept_multiple
    scanner = Scanner.new('abc')

    literal = scanner.accept('abcde')
    literal += scanner.accept('abcde')
    literal += scanner.accept('abcde')

    assert_equal('abc', literal)
  end
end
