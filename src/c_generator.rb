# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

# Generates C code for the supplied program
class CGenerator
  extend T::Sig

  def initialize(out:)
    @out = out
  end

  sig { params(_program: Program).void }
  def generate(_program)
    out.puts('int main(int argc, char* argv[]) { return 0; }')
  end

  private

  attr_reader :out
end
