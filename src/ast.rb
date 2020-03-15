# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Ast
  # A generic expression
  class Expression
  end
end

module Ast
  # A Binary expression has a left hand side expression, an operator and
  # a right hand side expression.
  class BinaryExpression < Expression
    extend T::Sig

    sig { returns(Expression) }
    attr_reader :lhs

    sig { returns(String) }
    attr_reader :operator

    sig { returns(Expression) }
    attr_reader :rhs

    private

    sig { params(lhs: Expression, operator: String, rhs: Expression).void }
    def initialize(lhs:, operator:, rhs:)
      @lhs = lhs
      @operator = operator
      @rhs = rhs
    end
  end
end

# A literal value
module Ast
  # A Literal expression
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
end

module Ast
  # A NumericLiteral is an integer.
  class NumericLiteral < Literal
  end
end

module Ast
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
end
