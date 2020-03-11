# typed: true
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/ast.rb'
require_relative '../src/c_generator.rb'

class CGeneratorTest < Minitest::Test
  def test_generate_empty_program
    file = StringIO.new

    program = Program.new

    generator = CGenerator.new(out: file)
    generator.generate(program)

    assert_equal('int main(int argc, char* argv[]) { return 0; }', file.string)
  end
end
