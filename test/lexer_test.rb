# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/lexer.rb'

class TestLexer < Minitest::Test
  def test_scan_empty_source
    file = SimpleFile.new(name: 'empty.smpl', source: '', length: 0)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('', item.literal)
    assert_equal(Token::EOF, item.token)
  end

  def test_scan_integer
    file = SimpleFile.new(name: 'integer.smpl', source: '123', length: 3)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('123', item.literal)
    assert_equal(Token::INTEGER, item.token)
  end

  def test_scan_skips_whitespace
    file = SimpleFile.new(name: 'whitespace.smpl', source: " \t\n\r", length: 4)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(4, item.position)
    assert_equal('', item.literal)
    assert_equal(Token::EOF, item.token)
  end
end
