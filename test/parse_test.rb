# typed: false
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/lexer.rb'
require_relative '../src/parser.rb'

class ParserTest < Minitest::Test
  def test_parser_integer
    file = SimpleFile.new(name: 'integer.smpl', source: '123', length: 3)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    assert_equal(1, program.expressions.length)
    assert_kind_of(Ast::NumericLiteral, program.expressions[0])
  end

  def test_parse_binary_expression
    file = SimpleFile.new(name: 'add.smpl', source: '2 + 3', length: 5)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    assert_equal(1, program.expressions.length)
    assert_kind_of(Ast::BinaryExpression, program.expressions[0])
  end

  def test_parse_chained_binary_expression
    file = SimpleFile.new(name: 'add.smpl', source: '2 + 3 - 1', length: 5)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    binexp = program.expressions[0]
    assert_kind_of(Ast::BinaryExpression, binexp)
    assert_kind_of(Ast::BinaryExpression, binexp.rhs)
  end

  def test_parse_var_expression_single_identifier
    file = SimpleFile.new(name: 'var_single.smpl', source: 'var ident0', length: 10)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    varexp = program.expressions[0]
    assert_kind_of(Ast::VarExpression, varexp)
    assert_kind_of(Ast::Identifier, varexp.identifiers[0])
  end
end
