# frozen_string_literal: true

# typed: true

require 'sorbet-runtime'

require_relative('./expression.rb')

module AST
  # A Binary expression has a left hand side expression, an operator and
  # a right hand side expression.
  class Binary < Expression
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
