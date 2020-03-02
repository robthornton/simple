# typed: true
# frozen_string_literal: true

# A generic expression
class Expression
end

# A literal value
class Literal < Expression
  attr_reader :literal, :position

  def initialize(literal:, position:)
    @literal = literal
    @position = position
  end
end

# A NumericLiteral is an integer.
class NumericLiteral < Literal
end

# A Program consists of zero or more expressions.
class Program
  attr_reader :expressions

  def initialize
    @expressions = []
  end

  def add_expression(expression)
    @expressions << expression
  end
end
