# frozen_string_literal: true

# typed: strict

require 'sorbet-runtime'

module Simple
  # Scanner defines an interface to fetch the current character and
  # the character's position. It can accept any of a string of
  # characters and ignore input altogether.
  class ScannerInterface
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(String) }
    def character; end

    sig { abstract.returns(Integer) }
    def position; end

    sig { abstract.params(characters: String).returns(String) }
    def accept(characters); end

    sig { abstract.void }
    def ignore; end
  end
end
