# typed: true
# frozen_string_literal: true

require('sorbet-runtime')

require('ast.rb')

module Simple
  # Generates C code for the supplied program
  module CGenerator
    # Program code generator
    class Program
      extend T::Sig

      sig { params(out: T.any(File, StringIO)).void }
      def initialize(out:)
        @out = out
      end

      sig { params(program: AST::Program).void }
      def generate(program)
        out.print('int main(int argc, char* argv[]) { return ')
        Expression.generate(
          out: out,
          expression: T.cast(program.expressions[0], AST::Expression)
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

      sig { params(out: T.any(File, StringIO), expression: AST::Expression).void }
      def self.generate(out:, expression:)
        if expression.instance_of?(AST::NumericLiteral)
          Numeric.generate(out: out, expression: T.cast(expression, AST::NumericLiteral))
        end

        if expression.instance_of?(AST::Binary)
          Binary.generate(out: out, expression: T.cast(expression, AST::Binary))
        end
      end
    end
  end

  module CGenerator
    # Numeric literal generator
    class Numeric
      extend T::Sig

      sig { params(out: T.any(File, StringIO), expression: AST::NumericLiteral).void }
      def self.generate(out:, expression:)
        out.print(expression.literal)
      end
    end
  end

  module CGenerator
    # Binary expression generator
    class Binary
      extend T::Sig

      sig { params(out: T.any(File, StringIO), expression: AST::Binary).void }
      def self.generate(out:, expression:)
        Expression.generate(out: out, expression: expression.lhs)
        out.print(expression.operator)
        Expression.generate(out: out, expression: expression.rhs)
      end
    end
  end
end
