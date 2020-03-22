# typed: true
# frozen_string_literal: true

require('minitest/autorun')

require('ast.rb')
require('c_generator.rb')

class CGeneratorTest < Minitest::Test
  def test_generate_empty_program
    file = StringIO.new

    program = Simple::AST::Program.new
    program.add_expression(Simple::AST::NumericLiteral.new(literal: '42', position: 0))

    generator = Simple::CGenerator::Program.new(out: file)
    generator.generate(program)

    assert_equal('int main(int argc, char* argv[]) { return 42; }', file.string)
  end

  def test_generate_numeric
    numeric = Simple::AST::NumericLiteral.new(literal: '42', position: 0)
    file = StringIO.new

    Simple::CGenerator::Numeric.generate(out: file, expression: numeric)

    assert_equal('42', file.string)
  end

  def test_generate_binary_expression
    lhs = Simple::AST::NumericLiteral.new(literal: '1', position: 0)
    rhs = Simple::AST::NumericLiteral.new(literal: '2', position: 2)
    binexp = Simple::AST::Binary.new(lhs: lhs, operator: '+', rhs: rhs)

    file = StringIO.new
    Simple::CGenerator::Binary.generate(out: file, expression: binexp)

    assert_equal('1+2', file.string)
  end
end
