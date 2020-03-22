# frozen_string_literal: true

# typed: strict

module Parser
  # Parsers need to implement #parse
  class Interface
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(Ast::Program) }
    def parse; end
  end
end
