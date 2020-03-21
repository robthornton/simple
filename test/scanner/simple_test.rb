# typed: false
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../src/scanner/simple.rb'

class TestScanner < Minitest::Test
  def test_character
    scanner = Scanner::Simple.new('0')

    assert_respond_to(scanner, 'character')
    assert_equal('0', scanner.character)
  end

  def test_position
    scanner = Scanner::Simple.new('0')

    assert_respond_to(scanner, 'position')
    assert_equal(0, scanner.position)
  end

  def test_ignore_single_character_source_raises_error
    scanner = Scanner::Simple.new('0')

    scanner.ignore
    assert_equal('', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_ignore_with_source
    scanner = Scanner::Simple.new('abc')

    scanner.ignore
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept
    scanner = Scanner::Simple.new('abc')

    assert_equal('a', scanner.accept('a'))
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept_multiple
    scanner = Scanner::Simple.new('abc')

    literal = scanner.accept('abcde')
    character = ''
    literal += character until (character = scanner.accept('abcde')).empty?

    assert_equal('abc', literal)
  end
end
