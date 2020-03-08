# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

# A generic expression
class Expression
end

# A literal value
class Literal < Expression
  extend T::Sig

  sig { returns(String) }
  attr_reader :literal

  sig { returns(Integer) }
  attr_reader :position

  sig { params(literal: String, position: Integer).void }
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
  extend T::Sig

  sig { returns(T::Array[Expression]) }
  attr_reader :expressions

  sig { void }
  def initialize
    @expressions = []
  end

  sig { params(expression: Expression).void }
  def add_expression(expression)
    @expressions << expression
  end
end
