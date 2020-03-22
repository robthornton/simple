# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative('./expression.rb')

module Simple
  module AST
    # An Identifier
    class Identifier < Expression
      extend T::Sig

      sig { returns(String) }
      attr_reader :literal

      sig { returns(Integer) }
      attr_reader :position

      private

      sig { params(literal: String, position: Integer).void }
      def initialize(literal:, position:)
        @literal = literal
        @position = position
      end
    end
  end
end
