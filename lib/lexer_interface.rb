# frozen_string_literal: true

# typed: strict

module Simple
  # Lexer is a lexical analyzer. Each call to scan will return a new
  # Token.
  class LexerInterface
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(Item) }
    def scan; end
  end
end
