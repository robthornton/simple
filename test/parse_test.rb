# typed: false
# frozen_string_literal: true

require('minitest/autorun')

require('lexer.rb')
require('parser.rb')

class ParserTest < Minitest::Test
  def test_parser_integer
    file = Simple::File.new(name: 'integer.smpl', source: '123', length: 3)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    assert_equal(1, program.expressions.length)
    assert_kind_of(Simple::AST::NumericLiteral, program.expressions[0])
  end

  def test_parse_binary_expression
    file = Simple::File.new(name: 'add.smpl', source: '2 + 3', length: 5)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    assert_equal(1, program.expressions.length)
    assert_kind_of(Simple::AST::Binary, program.expressions[0])
  end

  def test_parse_chained_binary_expression
    file = Simple::File.new(name: 'add.smpl', source: '2 + 3 - 1', length: 5)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    binexp = program.expressions[0]
    assert_kind_of(Simple::AST::Binary, binexp)
    assert_kind_of(Simple::AST::Binary, binexp.rhs)
  end

  def test_parse_var_expression_single_identifier
    file = Simple::File.new(name: 'var_single.smpl', source: 'var ident0', length: 10)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    varexp = program.expressions[0]
    assert_kind_of(Simple::AST::Var, varexp)
    assert_kind_of(Simple::AST::Identifier, varexp.identifiers[0])
  end

  # def test_parse_var_expression_multiple_identifiers
  #   file = Simple::File.new(
  #     name: 'var_single.smpl',
  #     source: 'var ident0, ident1',
  #     length: 18
  #   )
  #   lexer = Lexer.new(file)
  #   parser = Simple::Parser.new(lexer)
  #   program = parser.parse

  #   varexp = program.expressions[0]
  #   assert_kind_of(Simple::AST::Var, varexp)
  #   assert_equal(2, varexp.identifiers.length)
  # end
end
