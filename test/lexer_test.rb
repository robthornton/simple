# typed: ignore
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/item.rb'
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
    assert_equal(Token::Integer, item.token)
  end

  def test_scan_skips_whitespace
    file = SimpleFile.new(name: 'whitespace.smpl', source: " \t\n\r", length: 4)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(4, item.position)
    assert_equal('', item.literal)
    assert_equal(Token::EOF, item.token)
  end

  def test_scan_unknown_character
    file = SimpleFile.new(name: 'unknown.smpl', source: '#', length: 1)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('#', item.literal)
    assert_equal(Token::Unknown, item.token)
  end

  def test_scan_add_operator
    file = SimpleFile.new(name: 'add.smpl', source: '+', length: 1)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('+', item.literal)
    assert_equal(Token::AddOperator, item.token)
  end

  def test_scan_subtract_operator
    file = SimpleFile.new(name: 'subtract.smpl', source: '-', length: 1)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('-', item.literal)
    assert_equal(Token::SubtractOperator, item.token)
  end

  def test_scan_multiply_operator
    file = SimpleFile.new(name: 'multiply.smpl', source: '*', length: 1)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('*', item.literal)
    assert_equal(Token::MultiplyOperator, item.token)
  end

  def test_scan_division_operator
    file = SimpleFile.new(name: 'division.smpl', source: '/', length: 1)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('/', item.literal)
    assert_equal(Token::DivisionOperator, item.token)
  end

  def test_scan_var_keyword
    file = SimpleFile.new(name: 'var.smpl', source: 'var', length: 3)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('var', item.literal)
    assert_equal(Token::Var, item.token)
  end

  def test_scan_identifier
    file = SimpleFile.new(name: 'ident.smpl', source: 'ident', length: 5)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal('ident', item.literal)
    assert_equal(Token::Identifier, item.token)
  end

  def test_scan_assignment
    file = SimpleFile.new(name: 'assignment.smpl', source: ':=', length: 2)
    lexer = Lexer.new(file)
    item = lexer.scan

    assert_equal(0, item.position)
    assert_equal(':=', item.literal)
    assert_equal(Token::Assignment, item.token)
  end
end
