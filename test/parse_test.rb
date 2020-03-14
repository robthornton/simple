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
    assert_kind_of(NumericLiteral, program.expressions[0])
  end

  def test_parse_binary_expression
    file = SimpleFile.new(name: 'add.smpl', source: '2 + 3', length: 5)
    lexer = Lexer.new(file)
    parser = Simple::Parser.new(lexer)
    program = parser.parse

    assert_equal(1, program.expressions.length)
    assert_kind_of(BinaryExpression, program.expressions[0])
  end
end
