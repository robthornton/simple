# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/ast.rb'
require_relative '../src/c_generator.rb'

class CGeneratorTest < Minitest::Test
  def test_generate_empty_program
    file_mock = Minitest::Mock.new
    file_mock.expect(:puts, nil, [
                       'int main(int argc, char* argv[]) { return 0; }'
                     ])

    program = Program.new

    generator = CGenerator.new(out: file_mock)
    generator.generate(program)

    file_mock.verify
  end
end
