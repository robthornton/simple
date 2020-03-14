# typed: true
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/ast.rb'
require_relative '../src/c_generator.rb'

class CGeneratorTest < Minitest::Test
  def test_generate_empty_program
    file = StringIO.new

    program = Ast::Program.new
    program.add_expression(NumericLiteral.new(literal: '42', position: 0))

    generator = CGenerator::Program.new(out: file)
    generator.generate(program)

    assert_equal('int main(int argc, char* argv[]) { return 42; }', file.string)
  end

  def test_generate_numeric
    numeric = NumericLiteral.new(literal: '42', position: 0)
    file = StringIO.new

    CGenerator::Numeric.generate(out: file, expression: numeric)

    assert_equal('42', file.string)
  end
end
