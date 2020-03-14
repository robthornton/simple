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

    sig { params(_program: Ast::Program).void }
    def generate(_program)
      out.print('int main(int argc, char* argv[]) { return 0; }')
    end

    private

    sig { returns(T.any(File, StringIO)) }
    attr_reader :out
  end
end

module CGenerator
  # Numeric literal generator
  class Numeric
    extend T::Sig

    sig { params(out: T.any(File, StringIO), expression: NumericLiteral).void }
    def self.generate(out:, expression:)
      out.print(expression.literal)
    end
  end
end
