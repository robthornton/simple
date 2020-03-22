# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative('./expression.rb')

module AST
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
