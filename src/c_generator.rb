# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'ast.rb'

# Generates C code for the supplied program
module CGenerator
  # Program code generator
  class Program
    extend T::Sig

    sig { params(out: T.any(File, StringIO)).void }
    def initialize(out:)
      @out = out
    end

    sig { params(program: Ast::Program).void }
    def generate(program)
      out.print('int main(int argc, char* argv[]) { return ')
      Expression.generate(
        out: out,
        expression: T.cast(program.expressions[0], Ast::Expression)
      )
      out.print('; }')
    end

    private

    sig { returns(T.any(File, StringIO)) }
    attr_reader :out
  end
end

module CGenerator
  # Expression
  class Expression
    extend T::Sig

    sig { params(out: T.any(File, StringIO), expression: Ast::Expression).void }
    def self.generate(out:, expression:)
      if expression.instance_of?(Ast::NumericLiteral)
        Numeric.generate(out: out, expression: T.cast(expression, Ast::NumericLiteral))
      end
      if expression.instance_of?(Ast::BinaryExpression)
        Binary.generate(out: out, expression: T.cast(expression, Ast::BinaryExpression))
      end
    end
  end
end

module CGenerator
  # Numeric literal generator
  class Numeric
    extend T::Sig

    sig { params(out: T.any(File, StringIO), expression: Ast::NumericLiteral).void }
    def self.generate(out:, expression:)
      out.print(expression.literal)
    end
  end
end

module CGenerator
  # Binary expression generator
  class Binary
    extend T::Sig

    sig { params(out: T.any(File, StringIO), expression: Ast::BinaryExpression).void }
    def self.generate(out:, expression:)
      Numeric.generate(out: out, expression: T.cast(expression.lhs, Ast::NumericLiteral))
      out.print(expression.operator)
      Numeric.generate(out: out, expression: T.cast(expression.rhs, Ast::NumericLiteral))
    end
  end
end
