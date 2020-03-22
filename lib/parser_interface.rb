# frozen_string_literal: true

# typed: strict

module Simple
  # Parsers need to implement #parse
  class ParserInterface
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(AST::Program) }
    def parse; end
  end
end
