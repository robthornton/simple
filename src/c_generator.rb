# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

# Generates C code for the supplied program
class CGenerator
  extend T::Sig

  sig { params(out: T.any(File, StringIO)).void }
  def initialize(out:)
    @out = out
  end

  sig { params(_program: Program).void }
  def generate(_program)
    out.print('int main(int argc, char* argv[]) { return 0; }')
  end

  private

  sig { returns(T.any(File, StringIO)) }
  attr_reader :out
end
