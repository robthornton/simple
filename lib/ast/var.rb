# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative('./expression.rb')

module Simple
  module AST
    # A var expression
    class VarExpression < Expression
      extend T::Sig

      sig { returns(T::Array[Identifier]) }
      attr_reader :identifiers

      sig { returns(Integer) }
      attr_reader :var

      private

      sig { params(var: Integer, identifiers: T::Array[Identifier]).void }
      def initialize(var:, identifiers:)
        @identifiers = identifiers
        @var = var
      end
    end
  end
end
