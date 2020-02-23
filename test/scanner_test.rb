# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/scanner.rb'

class TestScanner < Minitest::Test
  def test_new
    assert_raises(EndOfInputError) { Scanner.new }
  end

  def test_new_with_source
    Scanner.new('0')
    pass
  end

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

    assert_respond_to(scanner, 'ignore')
    assert_raises(EndOfInputError) { scanner.ignore }
    assert_equal('', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_ignore_with_source
    scanner = Scanner.new('abc')

    scanner.ignore
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end
end
