# typed: false
# frozen_string_literal: true

require('minitest/autorun')
require('scanner.rb')

class TestScanner < Minitest::Test
  def test_character
    scanner = Simple::Scanner.new('0')

    assert_respond_to(scanner, 'character')
    assert_equal('0', scanner.character)
  end

  def test_position
    scanner = Simple::Scanner.new('0')

    assert_respond_to(scanner, 'position')
    assert_equal(0, scanner.position)
  end

  def test_ignore_single_character_source_raises_error
    scanner = Simple::Scanner.new('0')

    scanner.ignore
    assert_equal('', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_ignore_with_source
    scanner = Simple::Scanner.new('abc')

    scanner.ignore
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept
    scanner = Simple::Scanner.new('abc')

    assert_equal('a', scanner.accept('a'))
    assert_equal('b', scanner.character)
    assert_equal(1, scanner.position)
  end

  def test_accept_multiple
    scanner = Simple::Scanner.new('abc')

    literal = scanner.accept('abcde')
    character = ''
    literal += character until (character = scanner.accept('abcde')).empty?

    assert_equal('abc', literal)
  end
end
