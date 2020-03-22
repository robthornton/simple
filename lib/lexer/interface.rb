# frozen_string_literal: true

# typed: strict

module Lexer
  # Lexer is a lexical analyzer. Each call to scan will return a new
  # Token.
  class Interface
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(Item) }
    def scan; end
  end
end
