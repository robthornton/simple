# typed: ignore
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../../src/item.rb'
require_relative '../../src/lexer/simple.rb'

class TestLexer < Minitest::Test
  def test_scan_empty_source
    file = Simple::File.new(name: 'empty.smpl', source: '', length: 0)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('', item.literal)
    assert_equal(Token::EOF, item.token)
  end

  def test_scan_integer
    file = Simple::File.new(name: 'integer.smpl', source: '123', length: 3)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('123', item.literal)
    assert_equal(Token::Integer, item.token)
  end

  def test_scan_skips_whitespace
    file = Simple::File.new(name: 'whitespace.smpl', source: " \t\n\r", length: 4)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(4, item.position)
    assert_equal('', item.literal)
    assert_equal(Token::EOF, item.token)
  end

  def test_scan_unknown_character
    file = Simple::File.new(name: 'unknown.smpl', source: '#', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('#', item.literal)
    assert_equal(Token::Unknown, item.token)
  end

  def test_scan_add_operator
    file = Simple::File.new(name: 'add.smpl', source: '+', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('+', item.literal)
    assert_equal(Token::AddOperator, item.token)
  end

  def test_scan_subtract_operator
    file = Simple::File.new(name: 'subtract.smpl', source: '-', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('-', item.literal)
    assert_equal(Token::SubtractOperator, item.token)
  end

  def test_scan_multiply_operator
    file = Simple::File.new(name: 'multiply.smpl', source: '*', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('*', item.literal)
    assert_equal(Token::MultiplyOperator, item.token)
  end

  def test_scan_division_operator
    file = Simple::File.new(name: 'division.smpl', source: '/', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('/', item.literal)
    assert_equal(Token::DivisionOperator, item.token)
  end

  def test_scan_var_keyword
    file = Simple::File.new(name: 'var.smpl', source: 'var', length: 3)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('var', item.literal)
    assert_equal(Token::Var, item.token)
  end

  def test_scan_identifier
    file = Simple::File.new(name: 'ident.smpl', source: 'ident', length: 5)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('ident', item.literal)
    assert_equal(Token::Identifier, item.token)
  end

  def test_scan_assignment
    file = Simple::File.new(name: 'assignment.smpl', source: ':=', length: 2)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal(':=', item.literal)
    assert_equal(Token::Assignment, item.token)
  end

  def test_scan_assignment
    file = Simple::File.new(name: 'comma.smpl', source: ',', length: 1)
    scanner = Scanner::Simple.new(file.source)
    lexer = Lexer.new(scanner: scanner, file: file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal(',', item.literal)
    assert_equal(Token::Comma, item.token)
  end
end
