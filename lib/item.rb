# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Simple
  # Token has constants represting the literal lexed.
  class Token < T::Enum
    enums do
      EOF = new
      Unknown = new
      Integer = new
      AddOperator = new
      SubtractOperator = new
      MultiplyOperator = new
      DivisionOperator = new
      Assignment = new
      Comma = new
      Identifier = new
      Var = new
    end
  end

  # Item is a lexed literal.
  class Item
    extend T::Sig

    sig { returns(String) }
    attr_reader :literal

    sig { returns(Integer) }
    attr_reader :position

    sig { returns(Token) }
    attr_reader :token

    private

    sig { params(literal: String, position: Integer, token: Token).void }
    def initialize(literal:, position:, token:)
      @literal = literal
      @position = position
      @token = token
    end
  end
end
