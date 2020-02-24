# frozen_string_literal: true

# Token has constants represting the literal lexed.
module Token
  EOF = 0
  INTEGER = 1
end

# Item is a lexed literal.
class Item
  attr_reader :literal, :position, :token

  private

  def initialize(literal:, position:, token:)
    @literal = literal
    @position = position
    @token = token
  end
end