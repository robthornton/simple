# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/scanner.rb'

class TestScanner < Minitest::Test
  def test_new
    Scanner.new
    pass
  end

  def test_new_with_source
    Scanner.new('0')
    pass
  end

  def test_character
    scanner = Scanner.new

    assert_respond_to(scanner, 'character')
    assert_equal('', scanner.character)
  end

  def test_position
    scanner = Scanner.new

    assert_respond_to(scanner, 'position')
    assert_equal(0, scanner.position)
  end
end
