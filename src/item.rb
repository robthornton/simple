# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

# Token has constants represting the literal lexed.
class Token < T::Enum
  enums do
    EOF = new(1)
    Unknown = new(2)
    Integer = new(3)
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
