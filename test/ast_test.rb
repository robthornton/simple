# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/ast.rb'

class TestAbstractSyntaxTree < Minitest::Test
  def test_numeric_literal
    l = NumericLiteral.new(literal: '42', position: 0)

    assert_equal(0, l.position)
    assert_equal('42', l.literal)
  end

  def test_program
    p = Program.new

    p.add_expression(NumericLiteral.new(literal: '0', position: 0))
    assert_equal(1, p.expressions.length)
  end
end
