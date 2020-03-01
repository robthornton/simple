# frozen_string_literal: true

# Generates C code for the supplied program
class CGenerator
  def initialize(out:)
    @out = out
  end

  def generate(_program)
    out.puts('int main(int argc, char* argv[]) { return 0; }')
  end

  private

  attr_reader :out
end
