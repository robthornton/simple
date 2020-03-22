# typed: true
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../../src/ast/ast.rb'

class TestAbstractSyntaxTree < Minitest::Test
  def test_numeric_literal
    l = AST::NumericLiteral.new(literal: '42', position: 0)

    assert_equal(0, l.position)
    assert_equal('42', l.literal)
  end

  def test_binary_expression
    lhs = AST::NumericLiteral.new(literal: '1', position: 0)
    rhs = AST::NumericLiteral.new(literal: '2', position: 0)
    be = AST::Binary.new(lhs: lhs, operator: '+', rhs: rhs)

    assert_equal(lhs, be.lhs)
    assert_equal('+', be.operator)
    assert_equal(rhs, be.rhs)
  end

  def test_identifier
    ident = AST::Identifier.new(literal: 'ident', position: 0)

    assert_equal('ident', ident.literal)
    assert_equal(0, ident.position)
  end

  def test_var_expression
    ident = AST::Identifier.new(literal: 'ident', position: 4)
    varexp = AST::VarExpression.new(var: 0, identifiers: [ident])

    assert_equal(0, varexp.var)
    assert_equal(ident, varexp.identifiers[0])
  end

  def test_program
    p = AST::Program.new

    p.add_expression(AST::NumericLiteral.new(literal: '0', position: 0))
    assert_equal(1, p.expressions.length)
  end
end
